Return-Path: <axboe@kernel.dk>
Subject: Re: Hang with blk-mq map series (block/008)
To: Ming Lei <ming.lei@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <d4cafa94-919c-e83d-eb91-d10dc06fc515@kernel.dk>
 <20180411020252.GA4494@ming.t460p>
 <6e1d9201-e0f6-cdf4-9572-c67bf5a7e06e@kernel.dk>
 <20180411023059.GE4494@ming.t460p>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <51ebd44f-d6b2-3657-a94c-fb22350bfaa6@kernel.dk>
Date: Tue, 10 Apr 2018 20:33:04 -0600
MIME-Version: 1.0
In-Reply-To: <20180411023059.GE4494@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/10/18 8:30 PM, Ming Lei wrote:
> On Tue, Apr 10, 2018 at 08:08:43PM -0600, Jens Axboe wrote:
>> On 4/10/18 8:02 PM, Ming Lei wrote:
>>> On Tue, Apr 10, 2018 at 09:51:41AM -0600, Jens Axboe wrote:
>>>> Hi Ming,
>>>>
>>>> Ran the above blktests on the current tree, and we end up getting
>>>> a hang that we never recover from. There's on request perpetually
>>>> stuck:
>>>>
>>>> root@dell:/sys/kernel/debug/block/nvme0n1/hctx2# cat busy 
>>>> 000000005e2b09fe {.op=READ, .cmd_flags=, .rq_flags=DONTPREP|IO_STAT|STATS, .state=in_flight, .tag=313, .internal_tag=-1}
>>>>
>>>> and no amount of manual running or kicking the queue will bring it
>>>> back to life. If I run it on 'master', it works fine.
>>>>
>>>> Did you run blktests on your series?
>>>
>>> Not yet.
>>>
>>> Will take a look at it, but this seems related with driver, since
>>> the request has been submitted to hardware already.
>>
>> It might be, but it repeatedly failed for me on for-linus, and not on
>> master. I can try doing some more runs just to gain more confidence.
> 
> Looks it is one IO vs CPU hotplug test, which was done before posting.
> Not reproduce it on NVMe inside KVM.
> 
> Will install a kernel and run it on real HW.

Sounds good. I'll do some more testing tomorrow to ensure that my
report was sound.

> BTW, could you share your lscpu inf
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                48
On-line CPU(s) list:   0-47
Thread(s) per core:    2
Core(s) per socket:    12
Socket(s):             2
NUMA node(s):          2
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 79
Model name:            Intel(R) Xeon(R) CPU E5-2650 v4 @ 2.20GHz
Stepping:              1
CPU MHz:               1201.251
CPU max MHz:           2900.0000
CPU min MHz:           1200.0000
BogoMIPS:              4394.61
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              30720K
NUMA node0 CPU(s):     0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46
NUMA node1 CPU(s):     1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 invpcid_single tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm cqm rdt_a rdseed adx smap intel_pt xsaveopt cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts


-- 
Jens Axboe
