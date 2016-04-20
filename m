Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo <paolo.valente@linaro.org>
Subject: Re: [PATCH RFC 10/22] block, bfq: add full hierarchical scheduling
 and cgroups support
To: Tejun Heo <tj@kernel.org>
References: <1454364778-25179-1-git-send-email-paolo.valente@linaro.org>
 <1454364778-25179-11-git-send-email-paolo.valente@linaro.org>
 <20160211222824.GD3741@mtj.duckdns.org>
Cc: Jens Axboe <axboe@kernel.dk>, Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
 linus.walleij@linaro.org, broonie@kernel.org
Message-ID: <57174CA7.5000706@linaro.org>
Date: Wed, 20 Apr 2016 11:32:23 +0200
MIME-Version: 1.0
In-Reply-To: <20160211222824.GD3741@mtj.duckdns.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

[Resending in plain text]

Il 11/02/2016 23:28, Tejun Heo ha scritto:
> Hello,  > > On Mon, Feb 01, 2016 at 11:12:46PM +0100, Paolo Valente wrote: >> 
From: Arianna Avanzini <avanzini.arianna@gmail.com> >> >> Complete 
support for full hierarchical scheduling, with a cgroups >> interface. 
The name of the added policy is bfq. >> >> Weights can be assigned 
explicitly to groups and processes through the >> cgroups interface, 
differently from what happens, for single >> processes, if the cgroups 
interface is not used (as explained in the >> description of the 
previous patch). In particular, since each node has >> a full scheduler, 
each group can be assigned its own weight. > > * It'd be great if how 
cgroup support is achieved is better >   documented. > > * How's 
writeback handled? > > * After all patches are applied, both 
CONFIG_BFQ_GROUP_IOSCHED and >   CONFIG_CFQ_GROUP_IOSCHED exist. > > * 
The default weight and weight range don't seem to follow the defined >   
interface on the v2 hierarchy.  The default value should be 100. > > * 
With all patches applied, booting triggers a RCU context warning. >   
Please build with lockdep and RCU debugging turned on and fix the >   
issue. > > * I was testing on the v2 hierarchy with two top-level 
cgroups one >   hosting sequential workload and the other completely 
random.  While >   they eventually converged to a reasonable state, 
starting up the >   sequential workload while the random workload was 
running was >   extremely slow.  It crawled for quite a while.

This malfunction seems related to a blkcg behavior that I did not
expect: the sequential writer changes group continuously. It moves
from the root group to its correct group, and back. Here is the
output of

egrep 'insert_request|changed cgroup' trace

over a trace taken with the original version of cfq (seq_write is of
course the group of the writer):

     kworker/u8:2-96    [000] d...   204.561086:   8,0    m   N cfq96A  
/seq_write changed cgroup
     kworker/u8:2-96    [000] d...   204.561097:   8,0    m   N cfq96A  
/ changed cgroup
     kworker/u8:2-96    [000] d...   204.561353:   8,0    m   N cfq96A  
/ insert_request
     kworker/u8:2-96    [000] d...   204.561369:   8,0    m   N cfq96A  
/seq_write insert_request
     kworker/u8:2-96    [000] d...   204.561379:   8,0    m   N cfq96A  
/seq_write insert_request
     kworker/u8:2-96    [000] d...   204.566509:   8,0    m   N cfq96A  
/seq_write changed cgroup
     kworker/u8:2-96    [000] d...   204.566517:   8,0    m   N cfq96A  
/ changed cgroup
     kworker/u8:2-96    [000] d...   204.566690:   8,0    m   N cfq96A  
/ insert_request
     kworker/u8:2-96    [000] d...   204.567203:   8,0    m   N cfq96A  
/seq_write insert_request
     kworker/u8:2-96    [000] d...   204.567216:   8,0    m   N cfq96A  
/seq_write insert_request
     kworker/u8:2-96    [000] d...   204.567328:   8,0    m   N cfq96A  
/seq_write insert_request
     kworker/u8:2-96    [000] d...   204.571622:   8,0    m   N cfq96A  
/seq_write changed cgroup
     kworker/u8:2-96    [000] d...   204.571640:   8,0    m   N cfq96A  
/ changed cgroup
     kworker/u8:2-96    [000] d...   204.572021:   8,0    m   N cfq96A  
/ insert_request
     kworker/u8:2-96    [000] d...   204.572463:   8,0    m   N cfq96A  
/seq_write insert_request
...

For reasons that I don't yet know, group changes are much more
frequent with bfq, which ultimately causes bfq to fail to isolate the
writer from the reader.

While I go on trying to understand why, could you please tell me
whether this fluctuation is normal, and/or point me to documentation from
which I can better understand this behavior, without bothering you
further?

Thanks,
Paolo

>  > * And "echo 100 > io.weight" hung the writing process. > > Thanks. >
