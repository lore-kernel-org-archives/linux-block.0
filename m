Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B824EC433EF
	for <linux-block@archiver.kernel.org>; Fri,  1 Apr 2022 23:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353392AbiDAX6i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Apr 2022 19:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352915AbiDAX6g (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Apr 2022 19:58:36 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F9655228
        for <linux-block@vger.kernel.org>; Fri,  1 Apr 2022 16:56:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id m18so3750842plx.3
        for <linux-block@vger.kernel.org>; Fri, 01 Apr 2022 16:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=mm5VyhOPq1TdsT5JnT8m8suW9TeEtMFHnoXAKsN2HeE=;
        b=UHmRp+BUeY66TIHR6F03L9u6b6Q7Kdr1tXHtuusBkZCow9Y8/NLkeYMAP69z0NsOJ7
         hlAY3Mwcrb5nNS/BnXGec1OBtE5VwYJSYC1085SRwMtqerXcZOAeJZ+cxj1uBWNlFern
         dPgX6/XJl4D66dqZXFjDeAFo/6ET8KHPRFXMiuhYR4JOWAD05u5zNHhGc4aXBVGRtsTZ
         6wqSGNpSW1LY5k4KugVJ2hFi4EEyIzmfwwfTFxK0m6Jh1Kb02vUaaTmtenAKPfseyUkq
         Af5RvdX6nX9ut1yajEMM4hB25uTeFuwcxQQUb9xSyF7ZnjU6T6+2++Hb1IX+w6JyMHN+
         ZorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=mm5VyhOPq1TdsT5JnT8m8suW9TeEtMFHnoXAKsN2HeE=;
        b=6HoM2Pk35avW/riz4/9yjewp4u2vXnH2IImesjUetqxlh/tc1mYLxBfMOmM2ZA1jF+
         3LnvdVeaACvTjLEMppHgci1D1jd/FGq49QLRpOuuvWrKZykeVBAMclUh2wOvIWIC+tSS
         X7ZtE1oGDVauIMU6+KvvhHqKYrvBp+bMTWxUxoL6OSBlHXRqdWtaZFVwzEMZGR79W74s
         KuNT39wU8HrwsAuaH/K18NwBOYGF1JlIgbzJpMWX1317dLHJUCiwuZdGhNNu/8kBfAKZ
         pawJBBasxFiRjJ1n1WiqYDbjiFV9jIhumN0eKLT05v+OLfHWghO9fNHHJ/Y/UYxnTzIK
         GVBw==
X-Gm-Message-State: AOAM533Sv6T1TPPwptEuwLyLjYgRqUWE6VCkXOGOjmMxByT2zOb87nW5
        1v5Yp0ek3qFPI9XKEQNXOK/zZx3O6A2+aQ==
X-Google-Smtp-Source: ABdhPJxgMG0EveQYd5O3fyosXaUby6tPZMYS1qdVhV2ijpzkrT2taMXWKKb46ZZTsM+Kb5IA1Nfo3g==
X-Received: by 2002:a17:902:6b44:b0:154:4bee:c434 with SMTP id g4-20020a1709026b4400b001544beec434mr12671042plt.43.1648857405638;
        Fri, 01 Apr 2022 16:56:45 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t15-20020a63b70f000000b00381510608e9sm3380139pgf.14.2022.04.01.16.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 16:56:45 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220401211842.2088096-1-phil@philpotter.co.uk>
References: <20220401211842.2088096-1-phil@philpotter.co.uk>
Subject: Re: [PATCH] cdrom: remove unused variable
Message-Id: <164885740494.761830.9691405009600226275.b4-ty@kernel.dk>
Date:   Fri, 01 Apr 2022 17:56:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 1 Apr 2022 22:18:42 +0100, Phillip Potter wrote:
> From: Enze Li <lienze@kylinos.cn>
> 
> The clang static analyzer reports the following warning,
> 
> File: drivers/cdrom/cdrom.c
> Warning: line 1380, column 7
> 	 Although the value stored to 'status' is used in enclosing
> 	 expression, the value is never actually read from 'status'
> 
> [...]

Applied, thanks!

[1/1] cdrom: remove unused variable
      commit: e9c1e280f2e18845d078a65378b897915d74d401

Best regards,
-- 
Jens Axboe


