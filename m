Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94045C433F5
	for <linux-block@archiver.kernel.org>; Thu, 31 Mar 2022 16:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239662AbiCaQL3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Mar 2022 12:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239622AbiCaQL2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 12:11:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708081275B6
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 09:09:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so1989470wms.2
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 09:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=gDhoX2vp0X4fbn9hhWYTzWQWTzyqRleqCJPPleiUnqg=;
        b=JgbCBKAqSiC8qCBt90VbvpL4ZRLaOSezEa0WJUg36jDzsZjQaye10l0Ru09XhFoa2i
         ttj5T91TR/oerfAId9B6KEZB5ABKwkWavhbPtHG5ZvMiTplSavBaGA0oATjXwO8fvzIr
         7mZCt2DGN04n734ZKWTF3U7IovtIPqEwFrwgHY9BBvLChS32DLTglD4GpsXV6O84EKuw
         D9pa/KC4l83exBuE31iH7yHDfc8VNseU5se9WcmLAR0dWN0KvdRUPRIB9KQ59/tZTaM/
         hJCA30GYNbNv30gBOWis6CwheV+wgua/6m1pd5nx91FO++jEA5yeQVg+gdvNSZQRDBIP
         Tc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=gDhoX2vp0X4fbn9hhWYTzWQWTzyqRleqCJPPleiUnqg=;
        b=KMz7rN5w65xRKpF8ZGLodChXWHlT6kHmkabk3AKZgUTzrR+v69Gl1tz2gHnPlX2et2
         KYAd9pHPLpj9weXBiIBGJm7w2XcBNqSA7LOnGTP8yOiTHFhNSqa6lgpgv5mjV5YyMe6g
         v/ScAxEUDnFgwAAmpmmN3VgaiXTxlz8ytulqL3OjPfkr5U9IOvo8J/HKmMYLuIVv0WuQ
         +vF+1Rh/ixl/0Vx3T8v+MdIDlGt4vjhnYF44HIdBoQTEWn31a2Vr7YzHEfnbtcRaEV31
         QMhg2+Jkr4ROwnMW4Kk1dOz/44Rxz3rebjynuRKsk5D+2kZOVqo5nRxhrsdYruo4TBgY
         ONLQ==
X-Gm-Message-State: AOAM533GDyIMItSe9y9AVepaZk7RRPUxOYLc3iypJCogSy4SAKVnpPjw
        Nn3/rfL0OGzzgFMPZ55AuI+aG4ONkKE=
X-Google-Smtp-Source: ABdhPJwMxLoaMcHBgIo+a7QEIePD7pPUqSyOagjFz8F6CJsPyhyQJyGN4VwwqK4CigmpaImryZMXeg==
X-Received: by 2002:a1c:f604:0:b0:38c:8ffd:dbb6 with SMTP id w4-20020a1cf604000000b0038c8ffddbb6mr5409657wmc.43.1648742978691;
        Thu, 31 Mar 2022 09:09:38 -0700 (PDT)
Received: from DESKTOP-R5VBAL5 ([39.53.224.185])
        by smtp.gmail.com with ESMTPSA id n2-20020adfb742000000b00205eda3b3c1sm1421929wre.34.2022.03.31.09.09.37
        for <linux-block@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 31 Mar 2022 09:09:38 -0700 (PDT)
Message-ID: <6245d242.1c69fb81.db242.683c@mx.google.com>
Date:   Thu, 31 Mar 2022 09:09:38 -0700 (PDT)
X-Google-Original-Date: 31 Mar 2022 12:09:37 -0400
MIME-Version: 1.0
From:   armanddreamlandestimation@gmail.com
To:     linux-block@vger.kernel.org
Subject: Estimating Services
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,=0D=0A=0D=0AWe provide estimation & quantities takeoff service=
s. We are providing 98-100 accuracy in our estimates and take-off=
s. Please tell us if you need any estimating services regarding y=
our projects.=0D=0A=0D=0ASend over the plans and mention the exac=
t scope of work and shortly we will get back with a proposal on w=
hich our charges and turnaround time will be mentioned=0D=0A=0D=0A=
You may ask for sample estimates and take-offs. Thanks.=0D=0A=0D=0A=
Kind Regards=0D=0AArmand Southern=0D=0ADreamland Estimation, LLC

