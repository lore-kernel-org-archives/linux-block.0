Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8CCC433E0
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 19:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE19920781
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 19:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Mj0lNO+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406543AbgFYTjd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406069AbgFYTjc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 15:39:32 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70155C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 12:39:32 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e22so5130107edq.8
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 12:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1RYVP7RsPWbvdNK3+/gxv8Vszb2G2vp2B65jcRHPcHM=;
        b=Mj0lNO+TBXyy8gRb54xE6p95SnVUuIN4PGdFiF0HLOlmQkpyHX69Ejdz6tG5yOrdia
         TMwPoimwxKBcwBxPQFVXVlibf3bt4awKJ4c2ZUeAecD8xVHh0mYBxCHo0ifvY6lDigtS
         umg64gWooHv7DoJiyPctoVfTEvEGaJpTVd7PApQF0sKq1X8Tb/eu/q3Vl1yy7/Kcvq/J
         UCycQ0wpz8QUaGB6+uzdpneSFKTUEptyjAmG13I2M37YJsdWuWaIadGfW9L6jfDr0zLa
         3lQ2sb5EuTZ0oeeL3GOtEefEpbaCQEL3b/BGDIm25zhOFqELBSGr1QC+duubcElPD4xv
         TxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1RYVP7RsPWbvdNK3+/gxv8Vszb2G2vp2B65jcRHPcHM=;
        b=p7jtjnCzVajv0R8O0ZNn+B+qP7y4tuJ/KRhys0hLuxWbRPzLcxoPnWTdLmNXxSHfb+
         2+tTkHp5LgscqzfyOj5IhuxC6e5IbCcRMfGQYrnThucSb7oJVL8JcXbKDYBnfS/TowyV
         QMiB4LvJnH9FHiclP4Q/Vo9/LpSSHECRLBMczvzLy/+FL2r1swhyZYQ+Bw2zh2dTreQW
         fEgHntnxeeC2GLxCrIez+oocrilP4SEICsdSTMGaneQlkLSgRXoPzGxvOudw/Rdpe/Fq
         Gtmd+G+S31bUj/UJacVEkK4+HomyYd4BWFE+2a9khotyjeJplRVzrRJV7auOxmH75nUg
         z5jA==
X-Gm-Message-State: AOAM532wZ2XzS5yb1MlkMWBMp4BpkME8HLfxPCzWofUmKSdZF/SOTQDd
        qKnGSL1moJ65sawlKYpLrMZ0sQ==
X-Google-Smtp-Source: ABdhPJy+Vvf8Olu9/gOJVvG04T6uxdaPwVGYi17GeoA2MKCxGZ7K66mt2Yn0E/w4muwetPUDUPdB/w==
X-Received: by 2002:a50:fa8d:: with SMTP id w13mr34100776edr.324.1593113971205;
        Thu, 25 Jun 2020 12:39:31 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id a2sm7919011ejg.76.2020.06.25.12.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 12:39:30 -0700 (PDT)
Date:   Thu, 25 Jun 2020 21:39:29 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk
Subject: Re: [PATCH 0/6] ZNS: Extra features for current patches
Message-ID: <20200625193929.eitl3th2mn2mlxu2@MacBook-Pro.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <2067b6ce-fea0-99cd-39c7-56cf219f56d5@lightnvm.io>
 <d7b3dc5f-a10c-bcf2-8d13-26301d7736df@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7b3dc5f-a10c-bcf2-8d13-26301d7736df@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25.06.2020 16:48, Matias Bjørling wrote:
>On 25/06/2020 15.04, Matias Bjørling wrote:
>>On 25/06/2020 14.21, Javier González wrote:
>>>From: Javier González <javier.gonz@samsung.com>
>>>
>>>This patchset extends zoned device functionality on top of the existing
>>>v3 ZNS patchset that Keith sent last week.
>>>
>>>Patches 1-5 are zoned block interface and IOCTL additions to expose ZNS
>>>values to user-space. One major change is the addition of a new zone
>>>management IOCTL that allows to extend zone management commands with
>>>flags. I recall a conversation in the mailing list from early this year
>>>where a similar approach was proposed by Matias, but never made it
>>>upstream. We extended the IOCTL here to align with the comments in that
>>>thread. Here, we are happy to get sign-offs by anyone that contributed
>>>to the thread - just comment here or on the patch.
>>
>>The original patchset is available here: 
>>https://lkml.org/lkml/2019/6/21/419
>>
>>We wanted to wait posting our updated patches until the base patches 
>>were upstream. I guess the cat is out of the bag. :)
>>
>>For the open/finish/reset patch, you'll want to take a look at the 
>>original patchset, and apply the feedback from that thread to your 
>>patch. Please also consider the users of these operations, e.g., dm, 
>>scsi, null_blk, etc. The original patchset has patches for that.
>>
>Please disregard the above - I forgot that the original patchset 
>actually went upstream.
>
>You're right that we discussed (I at least discussed it internally 
>with Damien, but I can't find the mail) having one mgmt issuing the 
>commands. We didn't go ahead and added it at that point due to ZNS 
>still being in a fluffy state.
>

Does the proposed IOCTL align with the use cases you have in mind? I'm
happy to take it in a different series if you want to add patches to it
for other drivers (scsi, null_blk, etc.).
