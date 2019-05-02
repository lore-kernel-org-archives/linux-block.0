Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0B1C43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 15:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E740F20675
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 15:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfEBPMY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 11:12:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36181 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfEBPMY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 11:12:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id v80so1284368pfa.3
        for <linux-block@vger.kernel.org>; Thu, 02 May 2019 08:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7K44ulmmjePBHRKGWYLNm7mDE64js6CsBZjU1Zvb/lQ=;
        b=V0XWavvgbPtBornepk41V8RBkeQE0zcSDIP6Z0ngofHoFiva7a3mN1qu9Wr1iw7vsv
         ayb5RGdswHrlA/1ErhN+JXAgFvsVstyy6OGTkIwMgKDQN98FRMvLS7PlLY2WI1OBB1zm
         tqIcEAxB/EWNw1fK471TJgmdc/bEYWOPn3KRVPpO40qHNPisgatWIpyUhMc2jsqKAQZK
         t3hgkWZM1fH78ydF+bRGZE7VhN9pfixkcuoOoNYW2RBiVAzsmJ3k2eDqSS5RWIVq29nd
         +TnxKAEnF17yM+NsahVD75ibxNog5nB9EauOH3yZWwhQav1zn6UTe7b51/w18iJ7yfXv
         lD7A==
X-Gm-Message-State: APjAAAW3tJ+ZIe31eFtn3ztPazP6kN8ep+zcJqAvvSgKbgqjUNgm2oxe
        pawLvaVpitTRgL3UuJn3Psg=
X-Google-Smtp-Source: APXvYqyWRT78sfcqdS0R6e4Ep8D/2uCC5tbe6lzMr4JyiajnhVp3pEcGWzU5dsKGJt4Fqc8c7Jm6OA==
X-Received: by 2002:a63:1852:: with SMTP id 18mr4520081pgy.283.1556809943162;
        Thu, 02 May 2019 08:12:23 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id e1sm54427427pfn.187.2019.05.02.08.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 08:12:22 -0700 (PDT)
Message-ID: <1556809940.12970.8.camel@acm.org>
Subject: Re: [RFC PATCH 01/18] blktrace: increase the size of action mask
From:   Bart Van Assche <bvanassche@acm.org>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date:   Thu, 02 May 2019 08:12:20 -0700
In-Reply-To: <SN6PR04MB4527BDC294F24B4954AD201786340@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
         <20190501042831.5313-2-chaitanya.kulkarni@wdc.com>
         <1556725711.19047.10.camel@acm.org>
         <SN6PR04MB4527BDC294F24B4954AD201786340@SN6PR04MB4527.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-05-02 at 03:43 +-0000, Chaitanya Kulkarni wrote:
+AD4 On 5/1/19 8:48 AM, Bart Van Assche wrote:
+AD4 +AD4 On Tue, 2019-04-30 at 21:28 -0700, Chaitanya Kulkarni wrote:
+AD4 +AD4 +AD4 -+ACM-define BLKTRACESETUP32 +AF8-IOWR(0x12, 115, struct compat+AF8-blk+AF8-user+AF8-trace+AF8-setup)
+AD4 +AD4 +AD4 +-
+AD4 +AD4 +AD4 +-/+ACo XXX: temp work around for RFC +ACo-/
+AD4 +AD4 +AD4 +-+ACM-define BLKTRACESETUP32 +AF8-IOWR(0x13, 115, struct compat+AF8-blk+AF8-user+AF8-trace+AF8-setup)
+AD4 +AD4 
+AD4 +AD4 This change breaks user space so this change is not acceptable. I think you
+AD4 +AD4 want to introduce a new ioctl instead of modifying an existing ioctl.
+AD4 +AD4 Additionally, have you considered to split the blktrace+AF8-api.h header file
+AD4 +AD4 into two header files: one with kernel-internal definitions and a second one
+AD4 +AD4 with definitions that are shared with user space (include/uapi/...)?
+AD4 
+AD4 I want to avoid modifying an existing IOCTL, I'll add a new ioctl and 
+AD4 update the tools to use the extension IOCTL and split the header file 
+AD4 also. Also I found that user space tools have replicated BLK+AF8-XX+AF8-XXX 
+AD4 definitions, will be okay to keep all those in one place and include 
+AD4 those from the appropriate header file ?

Hi Chaitanya,

I think all definitions that are relevant for the user space blktrace tool
should be moved into a header file under include/uapi/linux. I'm not sure
what the best strategy is to include that header file in the blktrace tool.
Another project that interfaces with the kernel (rdma-core+ADs see also
https://github.com/linux-rdma/rdma-core/) periodically copies kernel header
files into its own source code repository.

Bart.
