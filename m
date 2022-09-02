Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D8EECAAD2
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 00:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiIBARB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Sep 2022 20:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbiIBARA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 20:17:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9D75A2F1
        for <linux-block@vger.kernel.org>; Thu,  1 Sep 2022 17:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662077819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=70lKWmlrtQoxiqEddVxE204zBfW5n8dIdIq2Ch1+cXM=;
        b=MQYtpvVuVWNgrcbNr/NblDUULd5rFQiduTON2u6cPn4hRSBK74sdnZcBnWJLYT5KOGOm1/
        +jdFlAoXKTqYh2sA0qC2htvvCKEFnl0zVcDTIOMM1yNv0LQHWzd0UjmmnBwijGyUAM3cyE
        IcFeVKflgMW1fHOEkXD0SKd3JTUwNeU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-669-ysb-8Ng9Ma-4Ku45n9CObQ-1; Thu, 01 Sep 2022 20:16:58 -0400
X-MC-Unique: ysb-8Ng9Ma-4Ku45n9CObQ-1
Received: by mail-qt1-f200.google.com with SMTP id o21-20020ac87c55000000b00344646ea2ccso402566qtv.11
        for <linux-block@vger.kernel.org>; Thu, 01 Sep 2022 17:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=70lKWmlrtQoxiqEddVxE204zBfW5n8dIdIq2Ch1+cXM=;
        b=p5Fh9GzAQJ+IiwMlKw8+amhHJ4jL4POcJ0jHowA1hzP17KRRO9a2BwL0kOjAubpSLx
         65GMh6SbOBqQmm/wDrGcf8Mz65a45aMXFpbuwqE6PN/nlGXw4BVmV+VRrKi6pPXIe6XU
         EuZtkXxLG0fc4odcg+pPmWa2tvEO/azXMhuxsD8sKL71mJsG55iqabuXLnVlYEWsuSm5
         +A94uoqpOHJU57KMtdRVFdKWJAlQXNMfFUANfZD1Td70nYn4RCnBaZUWSH6gEMIr7ieQ
         0EKBe0BJXV21QNeUWdd5ENW6II4odEL2ECGpsPtjqC9cfvgB/veJr2fS87cOY0ow1rGn
         EvsQ==
X-Gm-Message-State: ACgBeo3FVVVZGC7CPoR6TfoKbc6bm+2rkRPHXOwAbsOtJHmL1uVPB/As
        et/gpIAZnXM0rfAQVhwbc0aZFbvVZ0brhOeDtez5f1Kdm/tgZsHFGtfQaQF1Pymjt8RLhycGkBh
        /WkFivjXxzdu/GcxEOTNVVw==
X-Received: by 2002:a05:620a:2551:b0:6b8:f97f:b855 with SMTP id s17-20020a05620a255100b006b8f97fb855mr21703760qko.260.1662077817841;
        Thu, 01 Sep 2022 17:16:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6oThe4Ex4yHgqF6bEQvTIX/Gkg5IvByk6dGpbsPU+Rt5JY04QaEnAC3Hf1+9V3KO2xRre6mg==
X-Received: by 2002:a05:620a:2551:b0:6b8:f97f:b855 with SMTP id s17-20020a05620a255100b006b8f97fb855mr21703745qko.260.1662077817650;
        Thu, 01 Sep 2022 17:16:57 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id x6-20020ac84a06000000b00342f8143599sm157323qtq.13.2022.09.01.17.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 17:16:57 -0700 (PDT)
Date:   Thu, 1 Sep 2022 20:16:56 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de, bvanassche@acm.org,
        pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        gost.dev@samsung.com, jaegeuk@kernel.org, matias.bjorling@wdc.com,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v12 09/13] dm-zone: use generic helpers to calculate
 offset from zone start
Message-ID: <YxFLeNfAb/Uzf5nD@redhat.com>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121911eucas1p2a55dec72a6d780123e6c7655aee72457@eucas1p2.samsung.com>
 <20220823121859.163903-10-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823121859.163903-10-p.raghav@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 23 2022 at  8:18P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> Use the bdev_offset_from_zone_start() helper function to calculate
> the offset from zone start instead of using power of 2 based
> calculation.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

