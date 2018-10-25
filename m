Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
To: Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-12-axboe@kernel.dk>
 <20181025215213.GA8141@localhost.localdomain>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8d70362e-0c15-5423-9616-0ef92e8c9fe3@kernel.dk>
Date: Thu, 25 Oct 2018 17:07:19 -0600
MIME-Version: 1.0
In-Reply-To: <20181025215213.GA8141@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 3:52 PM, Keith Busch wrote:
> On Thu, Oct 25, 2018 at 03:16:23PM -0600, Jens Axboe wrote:
>> A driver may have a need to allocate multiple sets of MSI/MSI-X
>> interrupts, and have them appropriately affinitized. Add support for
>> defining a number of sets in the irq_affinity structure, of varying
>> sizes, and get each set affinitized correctly across the machine.
> 
> <>
> 
>> @@ -258,13 +272,18 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
>>  {
>>  	int resv = affd->pre_vectors + affd->post_vectors;
>>  	int vecs = maxvec - resv;
>> +	int i, set_vecs;
>>  	int ret;
>>  
>>  	if (resv > minvec)
>>  		return 0;
>>  
>>  	get_online_cpus();
>> -	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs) + resv;
>> +	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs);
>>  	put_online_cpus();
>> -	return ret;
>> +
>> +	for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
>> +		set_vecs += affd->sets[i];
>> +
>> +	return resv + max(ret, set_vecs);
>>  }
> 
> This is looking pretty good, but we may risk getting into an infinite
> loop in __pci_enable_msix_range() if we're requesting too many vectors
> in a set: the above code may continue returning set_vecs, overriding
> the reduced nvec that pci requested, and pci msix initialization will
> continue to fail because it is repeatedly requesting to activate the
> same vector count that failed before.

Good catch, we always want to be using min() with the passed in maxvec
in there. How about this incremental?


diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 0055e252e438..2046a0f0f0f1 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -272,18 +272,21 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
 {
 	int resv = affd->pre_vectors + affd->post_vectors;
 	int vecs = maxvec - resv;
-	int i, set_vecs;
-	int ret;
+	int set_vecs;
 
 	if (resv > minvec)
 		return 0;
 
-	get_online_cpus();
-	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs);
-	put_online_cpus();
+	if (affd->nr_sets) {
+		int i;
 
-	for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
-		set_vecs += affd->sets[i];
+		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
+			set_vecs += affd->sets[i];
+	} else {
+		get_online_cpus();
+		set_vecs = cpumask_weight(cpu_possible_mask);
+		put_online_cpus();
+	}
 
-	return resv + max(ret, set_vecs);
+	return resv + min(set_vecs, vecs);
 }

-- 
Jens Axboe
