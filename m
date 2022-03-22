Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63200C433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 02:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbiCVCDM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 22:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbiCVCDL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 22:03:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDAE765A1
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 19:01:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so1085804pjb.5
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 19:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZBO+N7zoUM4gDOQ0yx3biP9Qz4QBn61Ix+9+pIvZ9Zo=;
        b=kMtzp7UGiNnCZrIRX+6DrQnnikhlYMVVPm8fANQ3wWG8BEARuXSPsjYzD0mV8BGl9o
         AYR6ryQRQdZTDOfeYyPzvC1mvxS93YnslUstw1q6Ha45+nx3HjhPU/wTb4uIo5BTeCgL
         c4QI0L5h5oJmXddI5OCpIBYhrvQJJesnyGGNfARGdNSisczH9JzBTWTCk2FCG01hE/fk
         upjHisj7DiNAI5iyHYSs6hBtw6g3qamotY1Nd80XJhlFpbK4H2QKljHaelcgoP+9lWfy
         +YbdRZ55XfbjvpGAnfXQ9JHJtlb6nOPtNlZwAZC/Roycl2djwPTHXlKy40VXYzZdc782
         mpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZBO+N7zoUM4gDOQ0yx3biP9Qz4QBn61Ix+9+pIvZ9Zo=;
        b=dbUTXp+J7ygkTp5xML40Bplz20mqwy+j+d+wVDOJOgURVDg0vml4uXgjli1QoBY6zD
         fWPe19SzUDYI8I60daK9RTLJnamCeVRgCds9uQ1oL03/a+B5XR8a2PaShFqSp5ovI4If
         3RwiL2us1incPsXgygMFazYJRX7awUayRJ2xNwglvc6Dr89WRSt64JDDJwpyRx640jcy
         79UvN52BQQ5ln6pLryCFv8CB+1I5POkJshToFMFyd+0o2wPDFQJC/0IjMNByxCZ008KA
         lbDpL05SRrwihRoWIYQN3iXfLYHRx49nc8rIZqEReop1YO5yZjMYRiOZoXSSaCR8TBlK
         d6SA==
X-Gm-Message-State: AOAM531khqTUQZTz9DM0x4RLA9MDQU+djZTIHhu4+snlNZBAQrWOqVyh
        i7zThdiA2Ssdpy78ARw+zWpGKQ==
X-Google-Smtp-Source: ABdhPJxEcKX03HpD8he6/N/6lmGw8Ux4jkEF+dlcEtPobUzrHGes92lxQ7HNMRXChIE8/CiTjTR+fw==
X-Received: by 2002:a17:902:bf06:b0:14d:8c72:96c6 with SMTP id bi6-20020a170902bf0600b0014d8c7296c6mr15687811plb.156.1647914482140;
        Mon, 21 Mar 2022 19:01:22 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p17-20020a056a000b5100b004fa6304632esm15468388pfo.66.2022.03.21.19.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 19:01:21 -0700 (PDT)
Message-ID: <9e78f4fb-f7c4-3f4f-cac1-40d4ee9455d5@kernel.dk>
Date:   Mon, 21 Mar 2022 20:01:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] lib/sbitmap: allocate sb->map via kvzalloc_node
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, "Ewan D . Milne" <emilne@redhat.com>
References: <20220316012708.354668-1-ming.lei@redhat.com>
 <YjkXenfaI7iSewSC@T590>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YjkXenfaI7iSewSC@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/22 6:25 PM, Ming Lei wrote:
> Hello,
> 
> On Wed, Mar 16, 2022 at 09:27:08AM +0800, Ming Lei wrote:
>> sbitmap has been used in scsi for replacing atomic operations on
>> sdev->device_busy, so IOPS on some fast scsi storage can be improved.
>>
>> However, sdev->device_busy can be changed in fast path, so we have to
>> allocate the sb->map statically. sdev->device_busy has been capped to 1024,
>> but some drivers may configure the default depth as < 8, then
>> cause each sbitmap word to hold only one bit. Finally 1024 * 128(
>> sizeof(sbitmap_word)) bytes is needed for sb->map, given it is order 5
>> allocation, sometimes it may fail.
>>
>> Avoid the issue by using kvzalloc_node() for allocating sb->map.
>>
>> Cc: Ewan D. Milne <emilne@redhat.com>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Ping...

Was waiting on a response to the question on why we don't make this
dependent on size, but upon look at kvzalloc_node(), this is already
what it does. So I guess this looks fine to me too.

-- 
Jens Axboe

