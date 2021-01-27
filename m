Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA88C433DB
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 08:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7164C2074F
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 08:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhA0IOm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 03:14:42 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:24880 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbhA0IMm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 03:12:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611735114; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=960hhNTG56+qX20fkyX8J9sKQsVs3STq7WvHt5UIqf8=;
 b=xMgEbeIYOQ5y04jbmSCar2uaOq60GLPZ+jYZSBjMmWXOaNRySmtarJqwiJR3IVYL7pKodDZJ
 VAvLeim6zaqgTzIp8xyF7JQ/wRXI/U8S16Cn1ZYqCiF7h9uSw6GGe/7nunGuRx3EysHDl/9j
 BVZR23DASnW+1Ho9oTV/UT974AQ=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI0MmE5NyIsICJsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60111d6983c9d4cc539c9124 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 Jan 2021 07:59:37
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3C403C43463; Wed, 27 Jan 2021 07:59:37 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 90577C433CA;
        Wed, 27 Jan 2021 07:59:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 27 Jan 2021 15:59:36 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Asutosh Das <asutoshd@codeaurora.org>, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stern@rowland.harvard.edu,
        "Bao D . Nguyen" <nguyenb@codeaurora.org>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 1/2] block: bsg: resume scsi device before
 accessing
In-Reply-To: <DM6PR04MB6575D64869B24B4275D63503FCBB9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <cover.1611719814.git.asutoshd@codeaurora.org>
 <c04a11a590628c2497cef113b0dfea781de90416.1611719814.git.asutoshd@codeaurora.org>
 <DM6PR04MB6575D64869B24B4275D63503FCBB9@DM6PR04MB6575.namprd04.prod.outlook.com>
Message-ID: <75c66862d61c63fcfa61cd6dce254169@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021-01-27 15:09, Avri Altman wrote:
>> 
>> Resumes the scsi device before accessing it.
>> 
>> Change-Id: I2929af60f2a92c89704a582fcdb285d35b429fde
>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
> Following this patch, is it possible to revert commit 74e5e468b664d?
> 

No, but this is a good finding... This change assumes
that the queue->queue_data is a scsi_device, which is
why we call scsi_auto_pm_get(). But for ufs_bsg's case,
queue->queue_data is a device...

Thanks,
Can Guo.

> Thanks,
> Avri
