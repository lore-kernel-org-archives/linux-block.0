Return-Path: <hare@suse.de>
Subject: Re: [PATCH 3/7] genirq/affinity: Handle pre/post vectors in
 irq_create_affinity_masks()
To: Christoph Hellwig <hch@lst.de>
References: <1478544462-9549-1-git-send-email-hch@lst.de>
 <1478544462-9549-4-git-send-email-hch@lst.de>
 <a7e25633-b9fb-468f-fd33-28dbc0368cc1@suse.de>
 <20161108145508.GA12519@lst.de>
Cc: tglx@linutronix.de, axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c9ba9026-8ff8-8717-60dc-92672724d5d8@suse.de>
Date: Tue, 8 Nov 2016 15:59:16 +0100
MIME-Version: 1.0
In-Reply-To: <20161108145508.GA12519@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/08/2016 03:55 PM, Christoph Hellwig wrote:
> [please trim the f***king context in your replies, thanks..]
>
> On Tue, Nov 08, 2016 at 09:15:27AM +0100, Hannes Reinecke wrote:
>>> +irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>>>  {
>>> -	int n, nodes, vecs_per_node, cpus_per_vec, extra_vecs, curvec = 0;
>>> +	int n, nodes, vecs_per_node, cpus_per_vec, extra_vecs, curvec;
>>> +	int affv = nvecs - affd->pre_vectors - affd->post_vectors;
>>>  	nodemask_t nodemsk = NODE_MASK_NONE;
>>>  	struct cpumask *masks;
>>>  	cpumask_var_t nmsk;
>> Check for NULL affd?
>
> We expect all callers to pass a valid one.

Which you don't in this patch:

@@ -697,7 +697,7 @@ static int msix_setup_entries(struct pci_dev *dev, 
void __iomem *base,
      int ret, i;

      if (affinity) {
-        masks = irq_create_affinity_masks(dev->irq_affinity, nvec);
+        masks = irq_create_affinity_masks(nvec, NULL);
          if (!masks)
              pr_err("Unable to allocate affinity masks, ignoring\n");
      }

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
