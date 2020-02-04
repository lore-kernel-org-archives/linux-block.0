Return-Path: <SRS0=vwZl=3Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F159C2D0B1
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 10:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11CD2082E
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 10:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FCkHhGiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgBDK4R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Feb 2020 05:56:17 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:45866 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgBDK4R (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Feb 2020 05:56:17 -0500
Received: by mail-wr1-f47.google.com with SMTP id a6so22364839wrx.12
        for <linux-block@vger.kernel.org>; Tue, 04 Feb 2020 02:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=aFK/2Wx9FJn4idRKXvPZxNTTRMJvAhHEsYoqajP1MSI=;
        b=FCkHhGiCGFzYm8QL8ohCiHrU50S3YbZrqUKQx9ENpCz1pnvAS32YVno3xo2W2YDRKC
         9caV80aQ7MJS4R1YdVhZ/KKrSkiIhGNkHmoPgc6vAu/N2GROpzAfX3MeNS7RZeKzC6bX
         34KIB1k8NsrqYrgL8G6xnrlOFpNH1FwdeRIvRjS3OrTCrluHKkPEHw1MFtwrOsHfWqrP
         0Z7kGoYki8cfFIk2Y2bVFEfPl5d3DTpSeY4/vV21UH9Faw/ZnOmnOrc+JzreBY9bNk6f
         zsdUqxo2IgXa3qN1E8Ajtu0PhI9JJbmaBAQNKtsQCioJk2y9SAlqxzRgd7vJJmBAz4GR
         9KXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=aFK/2Wx9FJn4idRKXvPZxNTTRMJvAhHEsYoqajP1MSI=;
        b=XHMxBZOVRNWvYbKY7bNBAkQvj0x44Vx1xzbRQFiSi5rSHTRsuYDsDNGp52knCLXhaO
         V8F9gXOVuH3HcRC8Q62qOdJ3iTFXufBZuI2DPOm3j0ObwaMftOTwIwrWnbcov0ALZZRJ
         dXBmn4PJ3y1vwTFyyH3W4x7SYEP4cMqHlw9DK6FaC9/pke6gPCC/jtS2hd5mpRu6oREL
         HoKrzVLVwSlAs8+cJJR8CQ17DNcD789CXfjj+Cis1eCgJavH6iud8S+gs9dFba10Ez31
         Xsoz1HZzzwvE6PJV0u/v8vYU2k7gBjs+X5RaAjcGLnSDK+iYUEzQJTSNHyATrgIkkll6
         Yzmw==
X-Gm-Message-State: APjAAAUL5cIVyHODRf8afpfyIuJrX8IpLOvBy677dukJhuJiU4iTIdwq
        /NTp3gm2FzSuw+wsUzmuiYPd6g==
X-Google-Smtp-Source: APXvYqw1Oa/hxZAD99pI9BwduC9xQUnAEU1O/WRAI4t+KljppZzMNF3xio/ajfgRJJGlJeVa+iqFfA==
X-Received: by 2002:a05:6000:1012:: with SMTP id a18mr11626832wrx.113.1580813773499;
        Tue, 04 Feb 2020 02:56:13 -0800 (PST)
Received: from [192.168.0.103] (84-33-74-252.dyn.eolo.it. [84.33.74.252])
        by smtp.gmail.com with ESMTPSA id g21sm3325955wmh.17.2020.02.04.02.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2020 02:56:12 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: iocost_monitor.py tells that iocost is not enabled
Message-Id: <8FD4B865-5984-476F-BE47-98938D162749@linaro.org>
Date:   Tue, 4 Feb 2020 11:56:10 +0100
To:     Tejun Heo <tj@kernel.org>,
        linux-block <linux-block@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Tejun,
the following:

$ cd linux/tools/cgroup
$ sudo python3 iocost_monitor.py sda

tells:

The kernel does not have iocost enabled

Yet:
$ cat /sys/fs/cgroup/unified/io.cost.qos=20
8:0 enable=3D1 ctrl=3Duser rpct=3D95.00 rlat=3D2500 wpct=3D95.00 =
wlat=3D5000 min=3D1.00 max=3D10000.00
$ cat /sys/block/sda/dev
8:0

If useful:
$ cat io.cost.model=20
8:0 ctrl=3Duser model=3Dlinear rbps=3D528156881 rseqiops=3D73442 =
rrandiops=3D72800 wbps=3D386453414 wseqiops=3D79718 wrandiops=3D73186

What am doing wrong?

Thanks,
Paolo=
