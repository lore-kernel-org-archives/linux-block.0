Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D64C4321E
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 22:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiK3Wyi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 17:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiK3Wyg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 17:54:36 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF22E91340
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 14:54:35 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id a9so2111527pld.7
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 14:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoPLEhU5DORJQ5Ef/f1dq5sjZrPTEwD6623ObT2R9mI=;
        b=M21ZFKha/QcxokiWvQtYDoS/d8D3WOW+b+Ec14rGc60MJ8cGdvjsXXxhNv5cTeEegg
         ml5vlbjZxLY1nl1RMxW1rPai4o/SiTzElP1KZ0RwdZsQj4HYjUvbY35EM8sULW18k96C
         mykC9WQ7LLiVRa71AR4kx1z3E88UJ5RD12BCgz4PQWW9Ya2GkZvMMufYVw/UK9WOiivx
         ezklBQ6MP6jA6UJq/KEzVnkHQZTNlNuv+SjeLA+ym0N602wcHDC2F5H8cvdvQS5PzfX1
         bewCxiOnVh6MwQo+v4Abg0qQs2Lt8lmiQo+rRiwBxsRKkZ4LiAo6BHZ6AVZEZ5j49g3R
         0IZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoPLEhU5DORJQ5Ef/f1dq5sjZrPTEwD6623ObT2R9mI=;
        b=SIFhZDbWlw/jppVOR07MsEmwiuywBd6vu4WIL258VLyzrN6Eg2lHUcS2VDZ+zJWVVG
         ACnk2/JaFHkoz29CKk4akfdWSRt6bdK9kcu7gZq5IQbDzhZzjdpxXyMpRvBRI4DbyWdd
         7z5xJC9I1qpyVqP0gvMAgVndADA3qsRZ3e0qOiuvq8D/7dVWjEF4RGR41D8Ldw5X4XmW
         sDpKCIaFNzShNLqew+cJvE9bMw4kCpnx1DBHF4VhTgOzmySoQKASOl+yujllPgzekRU/
         rBl+OjD5rvUkpsJ5pp2kEASoPP3vz8XpvQnWdsX25ont77dAmarl6b4hp0d59vQy+CmP
         rCpQ==
X-Gm-Message-State: ANoB5plvI8m/OU214Dsf0B4FsLiByYOgVT2H/6sHOm15/TuLYb6f5wMT
        0VoZgGi0cL+9xZsLB8RlZhst/Q==
X-Google-Smtp-Source: AA0mqf5jwoo9ZYxyxK6/6vtoHvjAp0Xu6ktyiFtdffoPeS7Ssk/bLfvCeNmwmxk5kcTphCD4SLM/8A==
X-Received: by 2002:a17:902:b20f:b0:188:d4ea:251f with SMTP id t15-20020a170902b20f00b00188d4ea251fmr56717474plr.36.1669848875250;
        Wed, 30 Nov 2022 14:54:35 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e20500b0017e9b820a1asm2006718plb.100.2022.11.30.14.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 14:54:34 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
In-Reply-To: <20221130175653.24299-1-jack@suse.cz>
References: <20221130175653.24299-1-jack@suse.cz>
Subject: Re: [PATCH] block: Do not reread partition table on exclusively open device
Message-Id: <166984887413.508963.14681184412971925481.b4-ty@kernel.dk>
Date:   Wed, 30 Nov 2022 15:54:34 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d377f
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 30 Nov 2022 18:56:53 +0100, Jan Kara wrote:
> Since commit 10c70d95c0f2 ("block: remove the bd_openers checks in
> blk_drop_partitions") we allow rereading of partition table although
> there are users of the block device. This has an undesirable consequence
> that e.g. if sda and sdb are assembled to a RAID1 device md0 with
> partitions, BLKRRPART ioctl on sda will rescan partition table and
> create sda1 device. This partition device under a raid device confuses
> some programs (such as libstorage-ng used for initial partitioning for
> distribution installation) leading to failures.
> 
> [...]

Applied, thanks!

[1/1] block: Do not reread partition table on exclusively open device
      commit: 8d67fc20caf8b08ef6c90a04970846a950d46dd1

Best regards,
-- 
Jens Axboe


