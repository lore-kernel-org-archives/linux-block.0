Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1ACC433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 22:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiKPWMG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 17:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiKPWLz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 17:11:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CAB6A75B
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 14:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668636658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7vamPlcLskGy2JvIhU266turZK2l7Sx2cyKxaPLx7j8=;
        b=LQSoesqOO4/h42gmNJgeooN/LmZozKG2dDKPd53rVFJisXZqywH0br4J/ZmXqCOzB2VqzO
        sVg3ecWdtS+AYCTW99Seun8OA2YYnKwzJPUakij/4LFKFaD+F33a4+QWjloP0CAfokULfh
        aMDvDA0dv5sc39TFZrc5nCAazIB4mCA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-599-zm-HfknSPUmiJrzBXbernQ-1; Wed, 16 Nov 2022 17:10:54 -0500
X-MC-Unique: zm-HfknSPUmiJrzBXbernQ-1
Received: by mail-qk1-f199.google.com with SMTP id bi42-20020a05620a31aa00b006faaa1664b9so29273qkb.8
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 14:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vamPlcLskGy2JvIhU266turZK2l7Sx2cyKxaPLx7j8=;
        b=7T4KikEIP35CWRNLllFmPxajsQCbQzc0aq6HC55Q9a9TYP2E5NScCaye+qXcPeuDna
         4MqYmDt303VenzFe3adu13h9Hofdb2c3RsYV9KBZVu9p2hFEZ/Hv8XY/YhzJgZigNoae
         ew/i83SnIvZ8RELtT7XXtl2N/yu8NZ4aWmjoopoSr8o9jqwmedkAKk90LTvjMvOYcgJD
         wpKLQem7meoSN0toZUvKIQ7AOswhIotZ0T57PUSVnpgZjLw8h9WAH3pyREL+7G3zg1nq
         6sBXStYcK1tRsDmH96EGdCa2injwpgpgeupTVPwa+hjF/xuJDDrBViEpKccEpT8r7zln
         TDdw==
X-Gm-Message-State: ANoB5plAPjd/v22ve7fykfDUyPQfClTyjKLuDcT+KqvsubHFloFlrMZl
        qSrZZDBIDb/lByV/QTmgOc/OOnEg/YOqXPhi968OQ39EUPMsuMBMm66t6X3oNjvWq55JekaGPlq
        Y5MyE2qxW6Z82s/kyzUoqUA==
X-Received: by 2002:a0c:f4cd:0:b0:4b1:8ec4:4464 with SMTP id o13-20020a0cf4cd000000b004b18ec44464mr173721qvm.16.1668636654006;
        Wed, 16 Nov 2022 14:10:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4znPzbOMmRcBIPotkDkuJjcA84kJF/jJYUJhZDK9rm9yXJQWV/5W2Fydvh5O0bt2+81eunGg==
X-Received: by 2002:a0c:f4cd:0:b0:4b1:8ec4:4464 with SMTP id o13-20020a0cf4cd000000b004b18ec44464mr173707qvm.16.1668636653766;
        Wed, 16 Nov 2022 14:10:53 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id bq40-20020a05620a46a800b006f7ee901674sm10691245qkb.2.2022.11.16.14.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:10:53 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:10:52 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v3 01/10] block: clear ->slave_dir when dropping the main
 slave_dir reference
Message-ID: <Y3Vf7LYexIXiUeOE@redhat.com>
References: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
 <20221115141054.1051801-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115141054.1051801-2-yukuai1@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 15 2022 at  9:10P -0500,
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> From: Christoph Hellwig <hch@lst.de>
> 
> Zero out the pointer to ->slave_dir so that the holder code doesn't
> incorrectly treat the object as alive when add_disk failed or after
> del_gendisk was called.
> 
> Fixes: 89f871af1b26 ("dm: delay registering the gendisk")
> Reported-by: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

