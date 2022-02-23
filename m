Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913A7C433F5
	for <linux-block@archiver.kernel.org>; Wed, 23 Feb 2022 22:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbiBWWlV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Feb 2022 17:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiBWWlU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Feb 2022 17:41:20 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9095D29F
        for <linux-block@vger.kernel.org>; Wed, 23 Feb 2022 14:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645656052; x=1677192052;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=K4/JwvSMQQB3FANX9iPDUoXOsopzJGao+BsB8oNS+iM=;
  b=jLczsS5I5KLFvY3QQuZ3V6d5N6VijTz5igDw77cm0+N4gn6cFFycyodC
   AjtUGI5/Kobbw8oXtuGyXJvh83V4M3nwQeAGwgKb59KqNA6q9GZtVjx3z
   4x0gAp68z75XewkHJxn3YZmyCMR2YzDqGrfU7nWLzIxpWE9RJuAa1jkiG
   tnPCehkNbsDKTzv/bjbDtfsUbG8SFtcofyGFQ+Uszuu3b6bgNADXIMN8F
   k9c3P598gpo/v0i/Z0N9+zDrs/1hZ2Yw7l6OFbOiEQMM+wZW1s6c9cske
   Fs8cM1VOpCRy7todHfvC4tfS9uW8yGHjrimXDLSadozxk02ngpugo1iY6
   A==;
X-IronPort-AV: E=Sophos;i="5.88,392,1635177600"; 
   d="scan'208";a="194772480"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2022 06:40:51 +0800
IronPort-SDR: NYGAzWAKXWS8n31MG/ru49HzJMXQW1ss59186/TGTxnB6k51NTfj9vq2RpMHNYjAEr1NLxRju2
 BT5k7rzvDdxzNBmMGH1/kMDqj8Ei2FNbKAADZpU4DixYvcC3To/vWaJonnBW8PeQ7RMTg/OzCg
 00WzpkScH7U3HxHYrcEUFlVr4DtkHGfN+tVtXLFcMJpeltKTqJ0YB96533K5u14kOK5zBrmFuX
 dibXjlQRCJWEvGL5RcZPvYIefbAh4x3hMA4rEFx9rJVO5QTBXYmy0eXrd8NpeYUqxWwJJnIPsX
 5Cj624vTXWrmYZGE59mA+kVQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 14:12:22 -0800
IronPort-SDR: X5XXcnQ5NpSv23T2R9M5GiDcTUAwEaluRQU2DEKL0KSrPdF7LgGO/iNLD5maPmdKD7lc0aRe48
 JVMwA2LDpdF+NjtT9xkmn9JkeiS2RDBXx47+VOWlxYnEQLN72VccvX+vSzIVm2TG+cnL8taX+S
 ZfbfnpQdGb2VcsP0syS5QzlNjOgTVjdgM0qjwlmfwV40EDPqRSMxiyUyuiQg9kBXO8SeqBUuNZ
 UL0fb0g+nxEhYbg3DIg0fH9rYIKtCRRrl+FNYzQUFOMkrCV7p9uy1wr0AnlEEgPbNUNrek/jeB
 OzI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 14:40:51 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K3rbk2rSTz1Rwrw
        for <linux-block@vger.kernel.org>; Wed, 23 Feb 2022 14:40:50 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645656049; x=1648248050; bh=K4/JwvSMQQB3FANX9iPDUoXOsopzJGao+Bs
        B8oNS+iM=; b=YWwKP91sTnsGhSQ05i+Xo7vHG7+DFcI/n6iSTZuduxuu+GeoVq6
        qOnuTsai95/R4Sv3XMJrWVoIEjr9q/cShP6nINtWFQWtvSwoO4JS0aOP/BUSsQpt
        ycqJ8L5HoklofTg2wEhgRL6++yoCUBUkkDoKoiQiSNFeVxSXxgMIarH/FxMC1XFi
        WKAtmq3B81QPYIWuj0IuDHVRDV8vNjJhlI0dQhmRomNrcAukl1tvQsiQC420XMqp
        ydF4xzO+PI2pevuQ7DAKw5hBsuQxBZTrw+91gMP0Ft7dFIK9B9zUl7CTtM2a4aw8
        18zlrABe82bvUNXFmP/E+IlTaYSo0/9doag==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Awc38TWj9QVp for <linux-block@vger.kernel.org>;
        Wed, 23 Feb 2022 14:40:49 -0800 (PST)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K3rbh5Ntgz1Rvlx;
        Wed, 23 Feb 2022 14:40:48 -0800 (PST)
Message-ID: <3702afe7-2918-42e7-110b-efa75c0b58e8@opensource.wdc.com>
Date:   Thu, 24 Feb 2022 07:40:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
References: <YhXMu/GcceyDx637@B-P7TQMD6M-0146.local>
 <a55211a1-a610-3d86-e21a-98751f20f21e@opensource.wdc.com>
 <YhXsQdkOpBY2nmFG@B-P7TQMD6M-0146.local>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YhXsQdkOpBY2nmFG@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/23/22 17:11, Gao Xiang wrote:
> On Wed, Feb 23, 2022 at 04:46:41PM +0900, Damien Le Moal wrote:
>> On 2/23/22 14:57, Gao Xiang wrote:
>>> On Mon, Feb 21, 2022 at 02:59:48PM -0500, Gabriel Krisman Bertazi wrote:
>>>> I'd like to discuss an interface to implement user space block devices,
>>>> while avoiding local network NBD solutions.  There has been reiterated
>>>> interest in the topic, both from researchers [1] and from the community,
>>>> including a proposed session in LSFMM2018 [2] (though I don't think it
>>>> happened).
>>>>
>>>> I've been working on top of the Google iblock implementation to find
>>>> something upstreamable and would like to present my design and gather
>>>> feedback on some points, in particular zero-copy and overall user space
>>>> interface.
>>>>
>>>> The design I'm pending towards uses special fds opened by the driver to
>>>> transfer data to/from the block driver, preferably through direct
>>>> splicing as much as possible, to keep data only in kernel space.  This
>>>> is because, in my use case, the driver usually only manipulates
>>>> metadata, while data is forwarded directly through the network, or
>>>> similar. It would be neat if we can leverage the existing
>>>> splice/copy_file_range syscalls such that we don't ever need to bring
>>>> disk data to user space, if we can avoid it.  I've also experimented
>>>> with regular pipes, But I found no way around keeping a lot of pipes
>>>> opened, one for each possible command 'slot'.
>>>>
>>>> [1] https://dl.acm.org/doi/10.1145/3456727.3463768
>>>> [2] https://www.spinics.net/lists/linux-fsdevel/msg120674.html
>>>
>>> I'm interested in this general topic too. One of our use cases is
>>> that we need to process network data in some degree since many
>>> protocols are application layer protocols so it seems more reasonable
>>> to process such protocols in userspace. And another difference is that
>>> we may have thousands of devices in a machine since we'd better to run
>>> containers as many as possible so the block device solution seems
>>> suboptimal to us. Yet I'm still interested in this topic to get more
>>> ideas.
>>>
>>> Btw, As for general userspace block device solutions, IMHO, there could
>>> be some deadlock issues out of direct reclaim, writeback, and userspace
>>> implementation due to writeback user requests can be tripped back to
>>> the kernel side (even the dependency crosses threads). I think they are
>>> somewhat hard to fix with user block device solutions. For example,
>>> https://lore.kernel.org/r/CAM1OiDPxh0B1sXkyGCSTEpdgDd196-ftzLE-ocnM8Jd2F9w7AA@mail.gmail.com
>>
>> This is already fixed with prctl() support. See:
>>
>> https://lore.kernel.org/linux-fsdevel/20191112001900.9206-1-mchristi@redhat.com/
> 
> As I mentioned above, IMHO, we could add some per-task state to avoid
> the majority of such deadlock cases (also what I mentioned above), but
> there may still some potential dependency could happen between threads,
> such as using another kernel workqueue and waiting on it (in principle
> at least) since userspace program can call any syscall in principle (
> which doesn't like in-kernel drivers). So I think it can cause some
> risk due to generic userspace block device restriction, please kindly
> correct me if I'm wrong.

Not sure what you mean with all this. prctl() works per process/thread
and a context that has PR_SET_IO_FLUSHER set will have PF_MEMALLOC_NOIO
set. So for the case of a user block device driver, setting this means
that it cannot reenter itself during a memory allocation, regardless of
the system call it executes (FS etc): all memory allocations in any
syscall executed by the context will have GFP_NOIO.

If the kernel-side driver for the user block device driver does any
allocation that does not have GFP_NOIO, or cause any such allocation
(e.g. within a workqueue it is waiting for), then that is a kernel bug.
Block device drivers are not supposed to ever do a memory allocation in
the IO hot path without GFP_NOIO.

> 
> Thanks,
> Gao Xiang
> 
>>
>>
>> -- 
>> Damien Le Moal
>> Western Digital Research


-- 
Damien Le Moal
Western Digital Research
