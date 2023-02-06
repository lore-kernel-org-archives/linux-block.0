Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C851C05027
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 18:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjBFS6I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 13:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBFS6H (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 13:58:07 -0500
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D4110EF
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 10:58:06 -0800 (PST)
Received: by mail-pl1-f176.google.com with SMTP id z1so13159935plg.6
        for <linux-block@vger.kernel.org>; Mon, 06 Feb 2023 10:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAQn+0YZ14IRJqdTSbIsPNqPQd/HMTT0JjeJ3ETDy9Q=;
        b=HdMemkq1szVmBsF52FKrLJwEyLIGASJrHaKt3t2iXrRXRKMr6Y0DLY5tZ4J51hDhzT
         20m46PURa0uU9Xck6iAFi4brEwVU1bZq0VRwoNHjJ8XvqnnND9G5hAn4nsDMoSv/bxQf
         5qRk/7jcSzMknokCCH3gYEVZ63C0ylgjUVybnIlxPBvuZ0VvwcAP6pMLbL01hAeJO7RQ
         arqstjtIEpmEUGPopHjywKUIAYSnSWdsJEdubqMGDDY9nyr/FnL79t7sGvgBflEBZzpA
         8K0Azc0e9Tcha0iOJXqVDamCkQVGZbXesXfZluz1gyzkQIY60G3GLUf2k4P2wBPGfTCu
         iE1w==
X-Gm-Message-State: AO0yUKW162CRxTQNoznCwDLMyS1bCdyyXo23mfevB30gw778+GVhoExZ
        Z22h6vDUI3l7VX5f0MbDpt4=
X-Google-Smtp-Source: AK7set+GyZO+b0cCcDn5XPP+KLR6IVMxlWfDT/otQpcSauZ0sR7CWL8GGHqGe1E9T8cAUJhyrnnMEw==
X-Received: by 2002:a17:90a:bf0f:b0:230:86c1:62dd with SMTP id c15-20020a17090abf0f00b0023086c162ddmr729472pjs.24.1675709886230;
        Mon, 06 Feb 2023 10:58:06 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:546b:df58:66df:fe23? ([2620:15c:211:201:546b:df58:66df:fe23])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090a400500b00230b8431323sm2363111pjc.30.2023.02.06.10.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 10:58:05 -0800 (PST)
Message-ID: <639ba3a3-4b6d-b540-02fd-0e68afd00ac6@acm.org>
Date:   Mon, 6 Feb 2023 10:58:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [LSF/MM/BPF BoF]: A host FTL for zoned block devices using UBLK
Content-Language: en-US
To:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        =?UTF-8?Q?J=c3=b8rgen_Hansen?= <Jorgen.Hansen@wdc.com>,
        "andreas@metaspace.dk" <andreas@metaspace.dk>,
        "javier@javigon.com" <javier@javigon.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "hans@owltronix.com" <hans@owltronix.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "hch@lst.de" <hch@lst.de>
References: <20230206100019.GA6704@gsv>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230206100019.GA6704@gsv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/6/23 02:00, Hans Holmberg wrote:
> I think we're missing a flexible way of routing random-ish
> write workloads on to zoned storage devices. Implementing a UBLK
> target for this would be a great way to provide zoned storage
> benefits to a range of use cases. Creating UBLK target would
> enable us experiment and move fast, and when we arrive
> at a common, reasonably stable, solution we could move this into
> the kernel.
> 
> We do have dm-zoned [3]in the kernel, but it requires a bounce
> on conventional zones for non-sequential writes, resulting in a write
> amplification of 2x (which is not optimal for flash).
> 
> Fully random workloads make little sense to store on ZBDs as a
> host FTL could not be expected to do better than what conventional block
> devices do today. Fully sequential writes are also well taken care of
> by conventional block devices.
> 
> The interesting stuff is what lies in between those extremes.
> 
> I would like to discuss how we could use UBLK to implement a
> common FTL with the right knobs to cater for a wide range of workloads
> that utilize raw block devices. We had some knobs in  the now-dead pblk,
> a FTL for open channel devices, but I think we could do way better than that.
> 
> Pblk did not require bouncing writes and had knobs for over-provisioning and
> workload isolation which could be implemented. We could also add options
> for different garbage collection policies. In userspace it would also
> be easy to support default block indirection sizes, reducing logical-physical
> translation table memory overhead.
> 
> Use cases for such an FTL includes SSD caching stores such as Apache
> traffic server [1] and CacheLib[2]. CacheLib's block cache and the apache
> traffic server storage workloads are *almost* zone block device compatible
> and would need little translation overhead to perform very well on e.g.
> ZNS SSDs.
> 
> There are probably more use cases that would benefit.
> 
> It would also be a great research vehicle for academia. We've used dm-zap
> for this [4] purpose the last couple of years, but that is not production-ready
> and cumbersome to improve and maintain as it is implemented as a out-of-tree
> device mapper.
> 
> ublk adds a bit of latency overhead, but I think this is acceptable at least
> until we have a great, proven solution, which could be turned into
> an in-kernel FTL.
> 
> If there is interest in the community for a project like this, let's talk!
> 
> cc:ing the folks who participated in the discussions at ALPSS 2021 and last
> years' plumbers on this subject.
> 
> Thanks,
> Hans
> 
> [1] https://trafficserver.apache.org/
> [2] https://cachelib.org/
> [3] https://docs.kernel.org/admin-guide/device-mapper/dm-zoned.html
> [4] https://github.com/westerndigitalcorporation/dm-zap

Hi Hans,

Which functionality would such a user space target provide that is not 
yet provided by BTRFS, F2FS or any other log-structured filesystem that 
supports zoned block devices?

Thanks,

Bart.
