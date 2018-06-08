Return-Path: <vrbagal1@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 08 Jun 2018 15:03:30 +0530
From: vrbagal1 <vrbagal1@linux.vnet.ibm.com>
To: Li Wang <liwang@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        snitzer@redhat.com, Kent Overstreet <kent.overstreet@gmail.com>,
        chuhu.ncepu@gmail.com, sachinp <sachinp@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] Fix bio_set copy
In-Reply-To: <CAEemH2fcvMh2jS2zF0uvUuCrpL79LoBHFEQ84_bsbYkzsvMRmQ@mail.gmail.com>
References: <20180607204541.13491-1-axboe@kernel.dk>
 <CAEemH2fcvMh2jS2zF0uvUuCrpL79LoBHFEQ84_bsbYkzsvMRmQ@mail.gmail.com>
Message-Id: <ac9087308264e32cfbfa364af24c83a8@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On 2018-06-08 11:42, Li Wang wrote:
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> After a recent change, dm ends up doing a straight copy of a
>> bio_set. This breaks for various items in that bio_set,
>> most notably lists. Provide a proper helper for it, and use it.
> 
> ​

I am not seeing the issue, I reported with this patch applied to latest 
mainline.

JOB ID     : 5d6db9ad320b92b77cd92056fb4514c9afa0feea
JOB LOG    : 
/root/avocado-korg/korg/results/job-2018-06-08T03.49-5d6db9a/job.log
  (1/4) memhotplug.py:memstress.test_hotplug_loop: PASS (254.14 s)
  (2/4) memhotplug.py:memstress.test_hotplug_toggle: PASS (246.81 s)
  (3/4) memhotplug.py:memstress.test_dlpar_mem_hotplug: PASS (3.95 s)
  (4/4) memhotplug.py:memstress.test_hotplug_per_numa_node: PASS (223.96 
s)
RESULTS    : PASS 4 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | 
CANCEL 0
JOB TIME   : 734.52 s
JOB HTML   : 
/root/avocado-korg/korg/results/job-2018-06-08T03.49-5d6db9a/results.html

      Reported-by: Venkat R.B <vrbagal1@linux.vnet.ibm.com>
      Tested-by: Venkat R.B <vrbagal1@linux.vnet.ibm.com>
> 
> I can confirm that the issue[1] was gone with this patchset applied.
> 
>    Tested-by: Li Wang <liwang@redhat.com>
> 
> ​
> [1] https://lkml.org/lkml/2018/6/7/36 [1]​
> 
> --
> 
> Regards,
> 
> Li Wang
> 
> 
> Links:
> ------
> [1] https://lkml.org/lkml/2018/6/7/36
