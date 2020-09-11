Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79058C43461
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 19:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 374EC22209
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 19:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fOOzyerU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgIKTOd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 15:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgIKTOc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 15:14:32 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1FCC061573
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 12:14:32 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f18so8108167pfa.10
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 12:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=BAqPbPUHEIp6jW3DAn8JnegsecIzGAswAeb9R+1L94g=;
        b=fOOzyerUwljnh1qE8UKPVDiRXni4o9PnD1Hvxrnnuzv8biGawkT2yjGSgAn98FW4lr
         8HB6pAL7Y6khAFkz2pbp9dXNQIC9bYeqx1Mu8uHvQduB8ZLUOmDtDrwfVqz/Ar/eMG0a
         7Pn2cjdF5AshLYkI/XaOsx6/fwclsbT/RXgX5L6dBmO4/pg9lkddxZG1WXDGWBsfQn8X
         8oNtNhncXgW3Zu6U4BuKrkmBODO+WjATHeeJj7aww7v3cB7S9ij2Ywgq2OhfNwWUvkcf
         nJ5vDeVOj4O47zRSNLmTeZYijox1OSc3Hcerz97Yu8gDK/FOILE0lbMDpi4TVQfjcEpS
         89Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=BAqPbPUHEIp6jW3DAn8JnegsecIzGAswAeb9R+1L94g=;
        b=izTzj2Brkk5MaaRoUYV2+uN+0kYAS46y5ZhUJuHVFXdS/KxOcf1yS025LhTsSJ1D7l
         LzLgkxj+SgJhJbXzQ0sU4lt+2MMMz1KTlo0j2tqmPGBuom7kUne2IrDADpu1rYktfsIK
         T+/16jpnnnjLskhSTyuffOfHqmGESbuieaZh9jl9+AtkvPqh9Y7s1XKohzucrO2XwtT8
         U9amQfAAP1sqAM9LbhmL2Zt2XMw+P3x/qCy+WcGVaB1wmBURpzwBQHLMTAdVM9bBV/o6
         //F/yqu2jMv4pO/N/4+XGhgYNMgFXw5hFoGjW1Gk2SQ3gekSHiibLfM+j62lkkXuH2bK
         YMig==
X-Gm-Message-State: AOAM533gb4OnukYzVhyf8adwu3MVeIn0Z7OvvXrIWFJqpKGBChJeJeoZ
        4CM8GXSrHVwk2BGNRsHBdjGZKA==
X-Google-Smtp-Source: ABdhPJy4LjwfrgHmP9hDGYWAPVXI4lKvrgQjU0yDbAzEoHkviCtmwerDB1aYoLXNAWYy+OPYCov7KA==
X-Received: by 2002:a62:7f8d:0:b029:13e:d13d:a104 with SMTP id a135-20020a627f8d0000b029013ed13da104mr3348108pfd.32.1599851672069;
        Fri, 11 Sep 2020 12:14:32 -0700 (PDT)
Received: from localhost.localdomain ([2600:380:4953:91bd:8495:3742:6e97:1810])
        by smtp.gmail.com with ESMTPSA id y13sm3018286pfr.141.2020.09.11.12.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 12:14:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Jens Axboe <axboe@kernel.dk>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V5 0/4] blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING
Date:   Fri, 11 Sep 2020 13:14:29 -0600
Message-Id: <D4DF8CEF-AFFE-4EE1-947F-D9500007C7A0@kernel.dk>
References: <e517d3c4-86de-95bd-2013-d59eb48ba789@grimberg.me>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>
In-Reply-To: <e517d3c4-86de-95bd-2013-d59eb48ba789@grimberg.me>
To:     Sagi Grimberg <sagi@grimberg.me>
X-Mailer: iPhone Mail (18A5369b)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sep 11, 2020, at 1:12 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
>=20
> =EF=BB=BF
>>> Hi Jens,
>>>=20
>>> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
>>> and prepares for replacing srcu with percpu_ref.
>>>=20
>>> The 2nd patch replaces srcu with percpu_ref.
>>>=20
>>> The 3rd patch adds tagset quiesce interface.
>>>=20
>>> The 4th patch applies tagset quiesce interface for NVMe subsystem.
>> What is this series against?
>=20
> It didn't apply cleanly to me too until I realized it is
> on top of v4 of: "percpu_ref & block: reduce memory footprint of percpu_re=
f in fast path"

Right, and that=E2=80=99s what has the leak issue you found. I=E2=80=99ll ho=
ld off on this one until that=E2=80=99s sorted.=20

