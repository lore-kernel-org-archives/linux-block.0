Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA15EB64DD
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 02:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjGZCbK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jul 2023 22:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGZCbJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jul 2023 22:31:09 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF122688
        for <linux-block@vger.kernel.org>; Tue, 25 Jul 2023 19:31:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-682b1768a0bso1482478b3a.0
        for <linux-block@vger.kernel.org>; Tue, 25 Jul 2023 19:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690338667; x=1690943467;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pE4L/Xm3kLoI9HrD29L7K7aTmuDXrHPhtqkNw6IBbE=;
        b=PP7ylOiR4Y79Htdcg5A3hJw/5wDtFQF+3iOv654e2CF9cX30H4cPrnu5NXn4p4x8NT
         ASYJaTJK1ptUe1p0dPvHCvxaj3nwUg5kjrB5jn2E5Ry5VSz3XuVTwTWt+Dsk6oKjvoRH
         4EiIcHjw3hVjkubi8Naj0v73pdG9eVD5nfxgAVtGT7RnSZXDg0Gee0JGI09b3ZYdCbBP
         Ow3M1LaULfiBu5R9viG8XFf45DlF5SgTPztpbWJ1ng6yN41k15sDs9CXc6dAmPrar+or
         CxXbUFObKJt3HSoANB4Jpy6K/OS55dv55K6OchX7zsbNEXKjr2te6KVk7i/3MzDIstcn
         WtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690338667; x=1690943467;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pE4L/Xm3kLoI9HrD29L7K7aTmuDXrHPhtqkNw6IBbE=;
        b=IhIDrL1oQCM3xjOEXIDKupFWeiBbxeoyHtky/F2b6F4mz4by4iEcBzYCwjZbC4FyKA
         RYqOrN8v/lP0f3XwXPHqWhbyHq7e90A3jJ+9VQW/v+9+mm4R0PUG7mxs+cgJuwISOGmZ
         32/m0JwFfSKrygyEvMru5/u8MRhWWDqpWGn3S58dn7PD/XTBIXSd1D1uzEjxqnBVFPRM
         8ERupkKBm0JsBhefmu1lIe68WQI+c42OACoeLqw8IjMoQurk3cyBeHfimVtfjbLOgGfX
         5/70GsHHmjCYP5We/IiOUe4OEUfOKbWCfefT+uBbNA9ranvsKYr0Bhhh42RRscquZk24
         8YxA==
X-Gm-Message-State: ABy/qLa02ILDfRY6g5dbVC9PcAAaoY49jFbzrqpgMAaJnOutzUT4USSu
        1GpRyQAi3NH6nsStPhIcBux4Zg==
X-Google-Smtp-Source: APBJJlESzRrQMirYjq1n8EmHX8b287gHfS/qwbjZK569Ys7+IMy/+sEP8iskIkH09yqzZ4ELfIPkeA==
X-Received: by 2002:a05:6a21:6da6:b0:137:3eba:b808 with SMTP id wl38-20020a056a216da600b001373ebab808mr964035pzb.5.1690338667623;
        Tue, 25 Jul 2023 19:31:07 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p20-20020a637414000000b00563de16d60esm679198pgc.82.2023.07.25.19.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 19:31:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinyoung Choi <j-young.choi@samsung.com>
Cc:     hch@lst.de, martin.petersen@oracle.com
In-Reply-To: <20230725051839epcms2p8e4d20ad6c51326ad032e8406f59d0aaa@epcms2p8>
References: <CGME20230725051839epcms2p8e4d20ad6c51326ad032e8406f59d0aaa@epcms2p8>
 <20230725051839epcms2p8e4d20ad6c51326ad032e8406f59d0aaa@epcms2p8>
Subject: Re: [PATCH] block: cleanup bio_integrity_prep
Message-Id: <169033866680.863387.15476130342413439533.b4-ty@kernel.dk>
Date:   Tue, 25 Jul 2023 20:31:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 25 Jul 2023 14:18:39 +0900, Jinyoung Choi wrote:
> If a problem occurs in the process of creating an integrity payload, the
> status of bio is always BLK_STS_RESOURCE.
> 
> 

Applied, thanks!

[1/1] block: cleanup bio_integrity_prep
      commit: 51d74ec9b62f5813767a60226acaf943e26e7d7a

Best regards,
-- 
Jens Axboe



