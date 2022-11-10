Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA71C4332F
	for <linux-block@archiver.kernel.org>; Thu, 10 Nov 2022 19:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKJTtj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Nov 2022 14:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKJTti (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2022 14:49:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5332ADFCF
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 11:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668109721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gfbxZFxEhlWZYZh8MUln7gbj8wqnN8AA2+XD0JKtltQ=;
        b=HDGwGlQgODGFAE0FVv+ZEhqEEfmqxCljDR6BmOAt9uK/6zNvpMDR33NsULnwhCBrTNsBJc
        RcoiELFhMKNis1rBrsEhxEbmiuZdJQt+8J+9oq5I4vZixg8y/EfZXxk6FV7HTfXq1WfHgd
        XufNSk3Zx56586xXQhYJuGijc3m1KXs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-czSwp_XIMGO3xWBE9p45wQ-1; Thu, 10 Nov 2022 14:48:40 -0500
X-MC-Unique: czSwp_XIMGO3xWBE9p45wQ-1
Received: by mail-qv1-f72.google.com with SMTP id q16-20020a0ce210000000b004ba8976d3aaso2240746qvl.5
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 11:48:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfbxZFxEhlWZYZh8MUln7gbj8wqnN8AA2+XD0JKtltQ=;
        b=AGNuiIuILl1XA+o6uaw0wtxD8n+6hbX4vmOwpP2dv5ZJq+/TRDv7L8GiANCcxEBZqT
         pnAcH4ruC0SlINnFniC45l+6pPK5qAYFvGEVPSJEVcyh4ui8QTaVtFAkOYogfnjtGzjU
         gLOftiWrmc//BufKLS9QM/75LA1jGSBvtsmUgE6VmJJqlmCxdWWvLRrmfodiKIiP3uhW
         TpF6qZDL8zoDdGxDkNxMp+CapRZrmmm9TIRd4ytfUorXN/LKTvs1fjmQRNQYXqm0vWKU
         gnlMJgWW4PHrVFZsVtUpiRget9QQO6542EtIV1rbA5PFnyeSBZeV978jCpbdr8emYRbh
         roqA==
X-Gm-Message-State: ANoB5pldoE7eEv2t7mV7Q/+1MW5qUsLp2VnyIUcUqXYQeiya9VhrWd1l
        7Otl/3cj6t76rYZAWL5ZW+1azT7TRvnR8GjnJT9riyG7Zgqce9PbqJHKO8xqlgTHrCTQdvSGiYn
        aL/uIPgCgUDTeYc+W4gxFAQ==
X-Received: by 2002:ac8:5fc3:0:b0:3a5:9826:a3f2 with SMTP id k3-20020ac85fc3000000b003a59826a3f2mr14873014qta.243.1668109719596;
        Thu, 10 Nov 2022 11:48:39 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5th/wRJIR+zYpR6tRSP50/PBnDastQ7kzagzJ66Q1qmplYe0gU3MBfTSFabdkB4nsYC/JiLw==
X-Received: by 2002:ac8:5fc3:0:b0:3a5:9826:a3f2 with SMTP id k3-20020ac85fc3000000b003a59826a3f2mr14873007qta.243.1668109719403;
        Thu, 10 Nov 2022 11:48:39 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id l11-20020a37f90b000000b006fa9d101775sm142266qkj.33.2022.11.10.11.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 11:48:38 -0800 (PST)
Date:   Thu, 10 Nov 2022 14:48:37 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, "yukuai (C)" <yukuai3@huawei.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 5/7] dm: track per-add_disk holder relations in DM
Message-ID: <Y21VlVHSisUaHJC5@redhat.com>
References: <20221030153120.1045101-1-hch@lst.de>
 <20221030153120.1045101-6-hch@lst.de>
 <9b5b4c2a-6566-2fb4-d3ae-4904f0889ea0@huaweicloud.com>
 <20221109082645.GA14093@lst.de>
 <Y20+UNI0KV2VjUSi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y20+UNI0KV2VjUSi@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 10 2022 at  1:09P -0500,
Mike Snitzer <snitzer@redhat.com> wrote:
 
> The concern for race aside:
> I am concerned that your redundant bd_link_disk_holder() (first in
> open_table_device and later in dm_setup_md_queue) will result in
> dangling refcount (e.g. increase of 2 when it should only be by 1) --
> given bd_link_disk_holder will gladly just bump its holder->refcnt if
> bd_find_holder_disk() returns an existing holder. This would occur if
> a DM table is already loaded (and DM device's gendisk exists) and a
> new DM table is being loaded.

Nevermind, dm_setup_md_queue should only ever be called once.

