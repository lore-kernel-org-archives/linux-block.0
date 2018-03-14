Return-Path: <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
To: "Rafael J. Wysocki" <rafael@kernel.org>, Artem Bityutskiy
	<dedekind1@gmail.com>
CC: Ming Lei <ming.lei@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Jens
 Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	Laurence Oberman <loberman@redhat.com>
References: <20180308105358.1506-1-ming.lei@redhat.com>
 <1520515113.20980.31.camel@gmail.com> <20180308133440.GA2713@ming.t460p>
 <alpine.DEB.2.21.1803090011150.1454@nanos.tec.linutronix.de>
 <20180309012458.GD5228@ming.t460p>
 <alpine.DEB.2.21.1803091107520.1364@nanos.tec.linutronix.de>
 <20180309120833.GB30257@ming.t460p>
 <alpine.DEB.2.21.1803091531000.1364@nanos.tec.linutronix.de>
 <5e5f3852-5314-c479-245e-d0a575e533a5@cn.fujitsu.com>
 <1520926721.20980.210.camel@gmail.com> <20180313083535.GA21612@ming.t460p>
 <1520930375.20980.213.camel@gmail.com>
 <CAJZ5v0gcmkKVcgDBdt-aePgU0zvQwyf1yX5Qi_zRc1JfzaA5fg@mail.gmail.com>
 <ec20381d-b5d9-9e22-d94e-96bbb8d6278e@cn.fujitsu.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <a8770022-a437-9b8c-0b2e-cd6bdc0764ef@cn.fujitsu.com>
Date: Wed, 14 Mar 2018 12:11:26 +0800
MIME-Version: 1.0
In-Reply-To: <ec20381d-b5d9-9e22-d94e-96bbb8d6278e@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi Artem,

At 03/14/2018 11:29 AM, Dou Liyang wrote:
> Hi All,
> 
> At 03/13/2018 05:35 PM, Rafael J. Wysocki wrote:
>> On Tue, Mar 13, 2018 at 9:39 AM, Artem Bityutskiy 
>> <dedekind1@gmail.com> wrote:
>>> On Tue, 2018-03-13 at 16:35 +0800, Ming Lei wrote:
>>>> Then looks this issue need to fix by making possible CPU count
>>>> accurate
>>>> because there are other resources allocated according to
>>>> num_possible_cpus(),
>>>> such as percpu variables.
>>>
>>> Short term the regression should be fixed. It is already v4.16-rc6, we
>>> have little time left.
>>
>> Right.
>>
>>> Longer term, yeah, I agree. Kernel's notion of possible CPU count
>>> should be realistic.
>>
> 
> I did a patch for that, Artem, could you help me to test it.
> 

I didn't consider the nr_cpu_ids before. please ignore the old patch and
try the following RFC patch.

Thanks
	dou

--------------------------->8-------------------------------------

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 449d86d39965..96d568408515 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -671,6 +671,23 @@ static acpi_status __init 
acpi_processor_ids_walk(acpi_handle handle,

  }

+static void __init acpi_refill_possible_map(void)
+{
+       unsigned int cpu, nr = 0;
+
+       if (nr_cpu_ids <= nr_unique_ids)
+               return;
+
+       for_each_possible_cpu(cpu) {
+               if (nr >= nr_unique_ids)
+                       set_cpu_possible(cpu, false);
+               nr++;
+       }
+
+       nr_cpu_ids = nr_unique_ids;
+       pr_info("Allowing %d possible CPUs\n", nr_cpu_ids);
+}
+
  static void __init acpi_processor_check_duplicates(void)
  {
         /* check the correctness for all processors in ACPI namespace */
@@ -680,6 +697,9 @@ static void __init acpi_processor_check_duplicates(void)
                                                 NULL, NULL, NULL);
         acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID, 
acpi_processor_ids_walk,
                                                 NULL, NULL);
+
+       /* make possible CPU count more realistic */
+       acpi_refill_possible_map();
  }

  bool acpi_duplicate_processor_id(int proc_id)
