Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E3FC4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 13:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB54823AA8
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 13:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgLHNOR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 08:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgLHNOQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 08:14:16 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415C1C0613D6
        for <linux-block@vger.kernel.org>; Tue,  8 Dec 2020 05:13:36 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id r5so17490045eda.12
        for <linux-block@vger.kernel.org>; Tue, 08 Dec 2020 05:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4H0t76z3d9Gm8+rnlsRXMej2iqZW90QwJGGNcAOGfNQ=;
        b=JAzSmLxxgeFhhHjbJmv4czCcTVN37dDptyYJOl2vbRL3Kg0Eda4yv79sD8kMfO0W9S
         755X4aNtjn8/PDQ714OSMQWmUEpi3o2kj48M0Pau3F+eON22OEuSEQSgv+ssnT/+K6eC
         5aj7Lne6pqgTUjZ7ZbBS/DFNldcQ4aFV/HcS5eZwxiOlFpf0/ZDx99a28W3UW/PBlcL4
         +BweyvMen5WEQ6Zi/Y52ky0t+B/lP2/Sm1hV4x59IV2xMORTLdcltLMa+0e7nQqg6sg6
         wcabTKaDzHQcnkkWBuazi1q1wH8oXbHxXekHtbytDm2B0X1FmRK+IbhrMf17qT6GBY5i
         8rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4H0t76z3d9Gm8+rnlsRXMej2iqZW90QwJGGNcAOGfNQ=;
        b=okxn0LUWxOavb9f/ZeMQdw55Y0/TNEei553XDfvkv7uP2/bXu+FRuo43IjX/ykdXkE
         E99e0IIEXTdtayLq2ZFmpflZRt3PejAIBh80Yg+axXj+xD08EjhBjKTNwD+Iy01a0XXE
         zm7FRptLG19QWeRzih4FJ7H3nX/G0iu+TLJ+TDEzErDIVKT3B9Ae9pn+d10fO/ZFCgg+
         OsV3oyd6bCFDCtUl0tdZzDsceVE2vg8kgtIClik5DH/EGywySPBU0MfRRI2HNtFVj8PV
         tpOh/gZL9Tz4R/uipZaEYGVDG9t2udo7LtfWs4+fHe7FijgO+kCs/LjBC4/u40xf6e3W
         NcBQ==
X-Gm-Message-State: AOAM533F0HINWNkkAauRruDKnhNHktM9njJ2wU7Mo3E2otTXX8U7MjbL
        7FIMHRqMYbdt0Cut2gShQMan3A==
X-Google-Smtp-Source: ABdhPJxzR3lshkmLf680nwJwf3iSrf8fXTQ9WUttlW08OFCU+GJEW3f7mGgCqOCWWXeIGq2QqC1DUQ==
X-Received: by 2002:aa7:dac5:: with SMTP id x5mr25105016eds.198.1607433214946;
        Tue, 08 Dec 2020 05:13:34 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id u5sm16894960edp.5.2020.12.08.05.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 05:13:34 -0800 (PST)
Date:   Tue, 8 Dec 2020 14:13:33 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "selvajove@gmail.com" <selvajove@gmail.com>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
Message-ID: <20201208131333.xoxincxcnh7iz33z@mpHalley>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <20201207141123.GC31159@lst.de>
 <01fe46ac-16a5-d4db-f23d-07a03d3935f3@suse.de>
 <20201207192453.vc6clbdhz73hzs7l@mpHalley>
 <SN4PR0401MB35988951265391511EBC8C6E9BCD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201208122248.utv7pqthmmn6uwv6@mpHalley>
 <SN4PR0401MB35983464199FB173FB0C29479BCD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN4PR0401MB35983464199FB173FB0C29479BCD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08.12.2020 12:37, Johannes Thumshirn wrote:
>On 08/12/2020 13:22, Javier González wrote:
>> Good idea. Are you thinking of a sysfs entry to select the backend?
>
>Not sure on this one, initially I thought of a sysfs file, but then
>how would you do it. One "global" sysfs entry is probably a bad idea.
>Having one per block device to select native vs emulation maybe? And
>a good way to benchmark.

I was thinking a per block device to target the use case where a certain
implementation / workload is better one way or the other.

>
>The other idea would be a benchmark loop on boot like the raid library
>does.
>
>Then on the other hand, there might be workloads that run faster with
>the emulation and some that run faster with the hardware acceleration.
>
>I think these points are the reason the last attempts got stuck.

Yes. I believe that any benchmark we run would be biased in a certain
way. If we can move forward with a sysfs entry and default to legacy
path, we would not alter current behavior and enable NVMe copy offload
(for now) for those that want to use it. We can then build on top of it.

Does this sound like a reasonable approach?
