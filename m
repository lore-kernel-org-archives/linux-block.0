Return-Path: <SRS0=WP4r=WL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAC3C3A589
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 16:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B0C20644
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 16:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfHOQIr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:08:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:18515 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbfHOQIq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 12:08:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 09:08:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="188532545"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2019 09:08:46 -0700
Received: from fmsmsx152.amr.corp.intel.com (10.18.125.5) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 15 Aug 2019 09:08:45 -0700
Received: from fmsmsx102.amr.corp.intel.com ([169.254.10.170]) by
 FMSMSX152.amr.corp.intel.com ([169.254.6.42]) with mapi id 14.03.0439.000;
 Thu, 15 Aug 2019 09:08:45 -0700
From:   "Rajashekar, Revanth" <revanth.rajashekar@intel.com>
To:     Scott Bauer <sbauer@plzdonthack.me>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>
Subject: RE: [PATCH 3/3] block: sed-opal: OPAL_METHOD_LENGTH defined twice
Thread-Topic: [PATCH 3/3] block: sed-opal: OPAL_METHOD_LENGTH defined twice
Thread-Index: AQHVUh/4y1FQ9N75BUeIBH7jRP9Kt6b8Dw+AgABSc6A=
Date:   Thu, 15 Aug 2019 16:08:45 +0000
Message-ID: <834CCEEEEBB3654A923D02183C9F5D0108003F4B@FMSMSX102.amr.corp.intel.com>
References: <20190813214340.15533-1-revanth.rajashekar@intel.com>
 <20190813214340.15533-4-revanth.rajashekar@intel.com>
 <20190815040741.GC31938@hacktheplanet>
In-Reply-To: <20190815040741.GC31938@hacktheplanet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDM3Mzc2NjktMzUwMy00NTVjLWJmZjctMDljY2U5MWQxN2U5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQ2V3ZmMrMUxnb1F1cW1vZ21rYkw0RUU2eVNDXC9laHVtMDVxTTRyb0VvVW1WTTZTcVZ1bHpEeTRJQUNiT1lEV3gifQ==
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The re-definition error is thrown only when 2 different values are assigned to the same #define variable.
But in this case, the same value is defined twice... hence the compiler doesn't throw error.

Thank you :)
Revanth Rajashekar
-----Original Message-----
From: Scott Bauer [mailto:sbauer@plzdonthack.me] 
Sent: Wednesday, August 14, 2019 10:08 PM
To: Rajashekar, Revanth <revanth.rajashekar@intel.com>
Cc: linux-block@vger.kernel.org; Derrick, Jonathan <jonathan.derrick@intel.com>
Subject: Re: [PATCH 3/3] block: sed-opal: OPAL_METHOD_LENGTH defined twice

On Tue, Aug 13, 2019 at 03:43:40PM -0600, Revanth Rajashekar wrote:
> Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>

Two things,
Can we also change the title of this commit to:
"Removed duplicate OPAL_METHOD_LENGTH definition"
2nd, I'm dumb as hell now adays, why doesn't this throw a compiler error for multiple declarations?
