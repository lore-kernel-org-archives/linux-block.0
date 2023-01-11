Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A678BC54EBC
	for <linux-block@archiver.kernel.org>; Wed, 11 Jan 2023 04:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjAKEci (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 23:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjAKEch (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 23:32:37 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDF512AE4
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 20:32:35 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d3so15500361plr.10
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 20:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eO2nJDYhT5GJxHEdBGWFsvi67zSmV874nT01DvMhuq4=;
        b=outEOh82QabNhEiQ1TrZgFNAMf9mYkCkzjsLTDA+BlNK1lEPmT6UiEVvIBBKZ/yQsY
         hJ2S0oeeZFvpRpa6yJ9u9nQzC6tFEupSYt6gUu82ThSpTOLJ7wrOKdrOxRWCVBpDlS9y
         Xiqvm1fgVel3l27ViiaYZvzkk65ycpClBNzLG+h2c2L+z1c7iZtpcbXaamzucDWqXkJ0
         6PN99lkoaxPDpMCX3Y9DUkFl9Mmyad+/tqIDsyA06SY0fYPmTMhM8QtJ1Lo2WCN/OiGi
         46aA+mL2JVDGCLmO0XHHTWF8BI8EmGsUV7DLPj6U7FigkfbD/6SVHIaNssh0+SO4E5xO
         48LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eO2nJDYhT5GJxHEdBGWFsvi67zSmV874nT01DvMhuq4=;
        b=VVdESBHGgLloC56uGkSwBARcomukgXP+VaSYkvLYndyVu5Of6tw4Ijvs59umzXmhUw
         mO6Sc3nECuNLevrp/Zr5K+0EcC3uKGPl3lmIS+/xtSS+sn2Iq4/qhpSlTpyn+AnUKE0D
         XBVkKDBODc5GPa3KrCctBOO3dcIm2FxHVf6rNA2l3cGuypAQDvJ3vGd/4qX5f/Fsx59M
         U4fx/SOKFtr+52Bh/7ycW4q7OdmxQKPiKycwva1bT0jhHdSD6nNBh8qoDVq9Z69gMrU8
         s4EyfWsDtvzfUbYmkGeqc14KSTJpOdxVBv7AewRE2wNhI034hMPumy99bzVNuehup2SU
         E+kA==
X-Gm-Message-State: AFqh2kqrS9hAYoLen/bJ0SH16O6z9S8ck8nCDpiNUXSGQahoxwpyBxNl
        k4XvyUnOmo181S4s44ezLu1V9zpgnYV4qx5f
X-Google-Smtp-Source: AMrXdXsRDZ+nyVopkTlB5QMAjMsj66+Frkyrar/TGB/ULwNFDuM+Sicw/MST3pQtKnKZpNzwzNKx7A==
X-Received: by 2002:a05:6a20:a587:b0:a7:c027:f84a with SMTP id bc7-20020a056a20a58700b000a7c027f84amr22724548pzb.1.1673411555266;
        Tue, 10 Jan 2023 20:32:35 -0800 (PST)
Received: from smtpclient.apple ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w67-20020a628246000000b005892ea4f092sm4429975pfd.95.2023.01.10.20.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 20:32:34 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Jens Axboe <axboe@kernel.dk>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v9 1/6] block: add a sanity check for non-write flush/fua bios
Date:   Tue, 10 Jan 2023 21:32:23 -0700
Message-Id: <2544F354-58C0-4E90-8A1E-721AD455D6C8@kernel.dk>
References: <4a278c42-1f7b-f4c2-13c1-06d6fe52997f@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
In-Reply-To: <4a278c42-1f7b-f4c2-13c1-06d6fe52997f@opensource.wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
X-Mailer: iPhone Mail (20C65)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jan 10, 2023, at 2:58 PM, Damien Le Moal <damien.lemoal@opensource.wdc.co=
m> wrote:
>=20
> =EF=BB=BFOn 1/10/23 22:27, Damien Le Moal wrote:
>> From: Christoph Hellwig <hch@infradead.org>
>>=20
>> Check that the PREFUSH and FUA flags are only set on write bios,
>> given that the flush state machine expects that.
>>=20
>> [Damien] The check is also extended to REQ_OP_ZONE_APPEND operations as
>> these are data write operations used by btrfs and zonefs and may also
>> have the REQ_FUA bit set.
>>=20
>> Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> Christoph, Jens,
>=20
> Are you OK with this patch ?

I already acked a previous version, you just didn=E2=80=99t pick it up.=20

=E2=80=94=20
Jens Axboe

