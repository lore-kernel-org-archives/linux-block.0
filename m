Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373DBC433F5
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 15:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbiESPFF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 11:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240527AbiESPEk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 11:04:40 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75255ED70D
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 08:03:54 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id s12so3820203iln.11
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 08:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rj0LLD+GhcnwrTRHq/dFr3Mwh+FjHxEzsjGfPynBta8=;
        b=Sp2/uiiLNbgL9R1tphyrUyI7tgSy2JPlQLF1K2JNOaKRT6V/ibDgS7OjPvB3COMec2
         OaSQxtNqn4SoHtsZKkQFvaSwPftUrw2YyiL0FZoLZULvzgRe4jNAkc+CVeSRVHlZlaXm
         seoT9krghOGjnl8KddC+ryWzPKDDYHX8NtuYU7uwGUfGxGec2tiO1Zq4vWv/nKM1OySQ
         bfwEsMQiWVWYJKIK20b7dcd/8YZUf6k4HS5MNXv9lVqzQ8FZZZrpl3EWRbBOqO6ZWNJ3
         rTaO7gPV3yNYBwVLy+djNSgOU63D35AkX+viHNI9OW09GJg17YOcFizOnOcabFJ7MUD0
         bptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rj0LLD+GhcnwrTRHq/dFr3Mwh+FjHxEzsjGfPynBta8=;
        b=UCq6kOF+UGR9YF18w9uoZjVxnJNt+cmWl+ECj0cTQiv98P7m/QFNpG69BBQIqes41c
         EQlSBKYeokjm3RhER84XEC7LdwsFixj7XWW/XTpaoXXoXQO59sMfeemiraqAq/lWCJyE
         KQibeGwW7Glf2tMtuJm9MKC9VdDKW0ScoPquiv/3nx5TvGUaUxxHMQSW0IiUyCQyqhZO
         EzqUhAbdW/EqdvtDu/J+wcoqkGsZSR/MiSntL1EPrFhCrFSnm8+aIsSKUx5L7v7p7nyj
         Ie5d6Y9wBOETdlWIluTcv5S00NfsDtAOK11VX1DmUHM6/xWzkEsGTUkyonS7YD7FwpkH
         pX8g==
X-Gm-Message-State: AOAM533kRZ1XeQLFiP+jjJhS5Lz/RXe48kV8ghsgSwaQP5us74TQUSvA
        Ziz9p5pHSRWXGRCSWVyN0rror6hTZe9XtA==
X-Google-Smtp-Source: ABdhPJwcVoiz8Rc2uaOTrNO/AvGJLBT0BZxBlNiMr1idOVcadH9jYg5ZRjxvy6ArxdYVGO+7CLI64Q==
X-Received: by 2002:a05:6e02:12eb:b0:2d1:6335:8e28 with SMTP id l11-20020a056e0212eb00b002d163358e28mr2553116iln.51.1652972633870;
        Thu, 19 May 2022 08:03:53 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id cl9-20020a0566383d0900b0032b3a78177csm679227jab.64.2022.05.19.08.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 08:03:53 -0700 (PDT)
Message-ID: <1ca9f030-d873-5b27-6641-fadee25b30bd@kernel.dk>
Date:   Thu, 19 May 2022 09:03:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] nvme-fc: mask out blkcg_get_fc_appid() if
 BLK_CGROUP_FC_APPID is not set
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Muneendra <muneendra.kumar@broadcom.com>,
        James Smart <jsmart2021@gmail.com>
References: <20220519144555.22197-1-hare@suse.de>
 <84a7c290-5e75-3e24-0674-7b51dcafa2eb@kernel.dk>
 <0b33e180-9e23-f737-3c93-5b5b13a7ded2@suse.de>
 <be88c0b4-ddc6-c851-c160-a929adc1e433@kernel.dk>
 <20220519145931.GA25382@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220519145931.GA25382@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/19/22 8:59 AM, Christoph Hellwig wrote:
> On Thu, May 19, 2022 at 08:57:53AM -0600, Jens Axboe wrote:
>> I'm assuming that commit is from the scsi tree? It's certainly not in
>> mine. So your commit message may be correct, but since it was sent to me,
>> I was assuming it's breakage from my tree. Which doesn't appear to be the
>> case, and I don't see any of the SCSI maintainers on the to/cc.
> 
> Yes, all this went in through the scsi tree.

OK, Hannes please send it to the SCSI list/folks then.

-- 
Jens Axboe

