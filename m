Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF3AC433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 15:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbiF3Ptt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 11:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbiF3Pts (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 11:49:48 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1F6220F4
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 08:49:48 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 205-20020a1c02d6000000b003a03567d5e9so1574977wmc.1
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 08:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=Ai00vPmyKSILizlPtVY1TtxSHqjk+hDntQpOGH0MO4c=;
        b=VSJPWMtfriWCZV9Q5VW1OEW6eaAUwNNrkZWF3uvp8R5DXek6Vt3rZa3qbda8C+8Zer
         uy84c1cfu4VD7M2WO6ojlo0SxEk3GjHyQ+8b57f5IW5j0Ges0vdXXB5JFhL9RyVRwUmP
         B0XYsvSfqTDZ89LzyV4ro7a3NbwFlTTxcNlxK0jwBSIU7qt/Vf7xDmFYnSe5b4TPTPTu
         XW337udyp6GFnnIvpt8UgjJ1jPAdhofMCabGcjQf6l5YFwJavZ5GpQRoVTkU26L7rfmd
         LmnjJMGkA0oTcLkHZaEFUnLTsnOS42cMkE1WC9EiBaHcys+1J1FrFUiA3orMejV7oc8P
         755g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=Ai00vPmyKSILizlPtVY1TtxSHqjk+hDntQpOGH0MO4c=;
        b=O3xEfAv/hEVozhorUh9D+M672/QzjEzTfP/7woNGHWYjHP951a86Lv2p229l4IEfWi
         e+Lr7yKhOLjut8oVaED9+LDooMv1WXpbSAiM5pI9ntn9qVC6YXvkJO0+Z/87j3AV49BI
         xv5r7Wo4/83iy3vSS+YLWQwr25TutmY9Vin/WJRrRkFtmKAmVzwpZnbd/bwOsoKBntgV
         kP1RKhO3YoWTywc7M1zzOoWjVJLplWzVOKfogUh2UcrW2AfLh9ygOf7CMGMlMQ/2GEKe
         ZpEuNOvp8deHRr7cHCqRIxucfbduDXqLY1tkT4vuZnJnTwcSNKxje3VoPlZ1u++/q/9t
         4jdA==
X-Gm-Message-State: AJIora8NaEcPgYMeVB30jQTb8CyZPVgJA30fWA08k3xBKfeYqxqhetS0
        BwvBvPl3/iWPhEgsoN2fp4JdwqUavv0=
X-Google-Smtp-Source: AGRyM1sOpJN+aqUN7ryIb/FvysZkp8wjQnmvKuw/IywR/37VmpWbtBc1jKl8QvLN5LjpCfWTfHV4SQ==
X-Received: by 2002:a05:600c:1504:b0:3a1:84cb:9472 with SMTP id b4-20020a05600c150400b003a184cb9472mr3595183wmg.8.1656604186465;
        Thu, 30 Jun 2022 08:49:46 -0700 (PDT)
Received: from DESKTOP-L1U6HLH ([39.53.244.205])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d6343000000b0021a36955493sm19175886wrw.74.2022.06.30.08.49.45
        for <linux-block@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 30 Jun 2022 08:49:45 -0700 (PDT)
Message-ID: <62bdc619.1c69fb81.ee285.49f4@mx.google.com>
Date:   Thu, 30 Jun 2022 08:49:45 -0700 (PDT)
X-Google-Original-Date: 30 Jun 2022 11:49:47 -0400
MIME-Version: 1.0
From:   emmitt.dreamlandestimation@gmail.com
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
Kind Regards=0D=0AEmmitt Nagle=0D=0ADreamland Estimation, LLC

