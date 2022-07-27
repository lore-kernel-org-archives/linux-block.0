Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2261AC04A68
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 13:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiG0NBf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 09:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiG0NBd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 09:01:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A88A286E5
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 06:01:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ez10so31208760ejc.13
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 06:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=tjvezBqiBXqz8FBLH0Yx0x2i6hqzOhN4UfrVGdiK8vg=;
        b=mw5RDOKr/E9Nax6/5FkXdq/vYD1ybSqyEYy4nfXvrA9OhGsjb4NsMMwwp/UnHlw8Uo
         wgjM7KECPtCalX/pxAyhtlLjcQ9rNpUIUbLpL8V6yiLdEOc3Uh5tw4bFkH8DF/V4rJ4g
         JFqmbX7FISMQREmI76uAHt2SAvj6CEihmf2+6EncC0SlgcMVNxBHdTA3Z6driUVeQMpb
         wuVeSZd48odVIYe4+e17ZS76IZ2H6LaH2+K1YOzrwaU83RNOAKf+iB3P4V/4N33Gca87
         cHo9BHXybcV3mwETQaipjvMukbDkUAci4g/1fapm0Xgd50omt9QLcGqvS2noPBnL80Zh
         jG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=tjvezBqiBXqz8FBLH0Yx0x2i6hqzOhN4UfrVGdiK8vg=;
        b=T7NdcKcA1J2UeemfAb6wirJvo83vi3s427VJ6wsHlgBLT1ieE/MIHwFWcXjc48ZWtA
         aOP7EXbJx1U0QO7t2crTOF/Gp2Jat79SX+Fa6XmZ+w9qul/tlHKecFMqE+NwgUjeIEni
         36Lq3jeQQT/rq48z1qCp5RjOtiTEcUt8A/ArMLYDd3XJ3CL8yVZcl9nAlDx0UCN+R+7b
         SYv+ZJe5zHxrH2+0TTVOE7t8lppXbzml89EnyOEYmvSjH7nnaRF1KRvwL0YUiank7Mkm
         3X3UJCYeH6kbz1Y0fvNMEdMu9cNLguYbviXZTpxBNCG6F+fBJNWBvJJQ/Mhpk5L2n3Jz
         GF2g==
X-Gm-Message-State: AJIora9CJKpwNIPG/8iIiFIRfq57Q51IJOKp22uY+tlcTPS5l7B4Mg/E
        l9IFt/mZ0GhANpDur2hmBnNNIMUWG3I=
X-Google-Smtp-Source: AGRyM1uJR0RreDSFXkkMHaLYiQ8kUQxh+snDLLx8m4uUc/8rn+800qs/ehZ3sr7nNtCt5F+UXXQdEQ==
X-Received: by 2002:a17:907:28d5:b0:72b:4d89:9c6d with SMTP id en21-20020a17090728d500b0072b4d899c6dmr17713913ejc.128.1658926886345;
        Wed, 27 Jul 2022 06:01:26 -0700 (PDT)
Received: from [192.168.2.27] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id eg47-20020a05640228af00b0043bbcd94ee4sm10185201edb.51.2022.07.27.06.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 06:01:25 -0700 (PDT)
Message-ID: <975ea807-667d-3ef3-b3e2-26b22ea74029@gmail.com>
Date:   Wed, 27 Jul 2022 15:01:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
X-Mozilla-News-Host: news://nntp.lore.kernel.org:119
Content-Language: en-US
To:     linux-block <linux-block@vger.kernel.org>
Cc:     Ondrej Kozina <okozina@redhat.com>
From:   Milan Broz <gmazyland@gmail.com>
Subject: Errors in log with WRITE_ZEROES over loop on NFS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

We switched to using BLKZEROOUT ioctl in libcryptsetup, and now we see a lot of messages like

  : operation not supported error, dev loop1, sector 0 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0

But the operation succeeds (ioctl returns 0).

As it seems, this happens when a loop device is allocated over a file on NFS mounted directory.
Easy to reproduce (5.19-rc8) by doing this in NFS mounted dir:

  # truncate -s 1M test.img
  # losetup /dev/loop1 test.img
  # fallocate -zn -l 1048576 /dev/loop1


Shouldn't the block layer be quiet here and just switch to a different wipe method?
(I think it happens in other cases.)

It is perhaps just a benign message, but it can trigger some reports.

Milan

