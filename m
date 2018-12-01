Return-Path: <SRS0=alrN=OK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20D1C04EB9
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 14:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8E920834
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 14:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKfBQsyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8E920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbeLBBj6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 20:39:58 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:37661 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeLBBj6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 20:39:58 -0500
Received: by mail-it1-f173.google.com with SMTP id b5so2617153iti.2;
        Sat, 01 Dec 2018 06:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DpQI6BRhrQ36K8HjKAb49/qESHG5LMncVzanuIdvBHE=;
        b=fKfBQsyz3fn9nuUFbPTGKdtOOJPfL6vfHBsxs/BLbs9Zb2CvwyFW0ylxv9OAMI38Sd
         wUmQyjmqsxYnDH2McqUdzhAGvPgwfGTYt72dH/t4WtUeSc7bvISsFDnCaalLStbqs+L4
         cGfG29lpFNFXbk3fgFpj1OZnMRi2q0kS2qVVQcePEJeSfaBXprtwxujRJaVrQbSn3+Qr
         D8VyRxSB0FF0ilW4GsitNcaIj6e3lgQQxmAPlDBnXhRNCj902ZyKERHNmoMSVDv/prdJ
         a6T/ipVP4VqleZnjSCrJNxLoI58nsf1opleHqb840uNgsCWU9vVx5P3Z1aBS0RidxwHe
         6t9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DpQI6BRhrQ36K8HjKAb49/qESHG5LMncVzanuIdvBHE=;
        b=l3qnDEZLdzF94a/8+g2bzRoFyRiLv8GtWCtaJr1jDUa72ugcI/E4Yo3AMuQ5nOWsLx
         W5A7ex+2TiW6rwscU53ZASRd4nfpp3C7UpycDeN3hfnxbJ1AePmC7M0vGi+UHhWbtidX
         I4QVxLVR04q1OupE0s6poO+4EQ4s51UUcSEvhBfL8ub1l+9qtgMYKntqZWyWWQITKU2W
         ETpPw4N1D6LLfxBBAt+bcr1JIj4Patd3zdzWDRCV7rrR4fwEbKfmVP7Ku93uXQeMmBOx
         X7wmtXhhe6DVEhLjjbiqiswoVmGJKckRA2PU/Ruo3qBO2f4lbgeHvSYxzxZ5tCaSbCdB
         BHWg==
X-Gm-Message-State: AA+aEWa55EBSgCpmUDa9hAtQ0oh3+KDblOSpgF+Zs/qM3r+8LHO9acy/
        k1RKbZPrKJjqc5B4Yhew87hQFRKPTK3lcv+PCIk=
X-Google-Smtp-Source: AFSGD/X9SCgvNUMZAKzwLMCWTnG/xRv/V9w4vylhkAcWGi7CU6zmT44lS47egYgBF+xFvbfsAafpW86Uea5Xg1fIz0U=
X-Received: by 2002:a24:648f:: with SMTP id t137mr2262448itc.95.1543674440690;
 Sat, 01 Dec 2018 06:27:20 -0800 (PST)
MIME-Version: 1.0
References: <20181201032200.5746-1-tiny.windzz@gmail.com> <201812012108.iymkwaQi%fengguang.wu@intel.com>
In-Reply-To: <201812012108.iymkwaQi%fengguang.wu@intel.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sat, 1 Dec 2018 22:26:58 +0800
Message-ID: <CAEExFWv0Yv7=zUV4C-B2WRAUDQxCpGLggBcYMuVwkxkX0v76Zw@mail.gmail.com>
Subject: Re: [PATCH] block: Change to use DEFINE_SHOW_ATTRIBUTE macro
To:     lkp@intel.com
Cc:     kbuild-all@01.org, ed.cashin@acm.org, axboe@kernel.dk,
        philipp.reisner@linbit.com,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, josh.h.morris@us.ibm.com,
        pjk1939@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Already sent the second edition.

Thanks,
Yangtao
