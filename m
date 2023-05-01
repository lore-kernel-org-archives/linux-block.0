Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294E6C77B73
	for <linux-block@archiver.kernel.org>; Mon,  1 May 2023 04:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjEAEep (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 00:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjEAEen (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 00:34:43 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10C7E76
        for <linux-block@vger.kernel.org>; Sun, 30 Apr 2023 21:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682915682; x=1714451682;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nkXKET0X+VZyLa76opUGN5fYB6meokcOK9XJGSu20mQ=;
  b=V5T2LYEyYvIYPOlU8sf8bnbGmQIG9W5GUSyFZ4Af+aeLUJ6U8IEybNp8
   Ma++lurEINOX8/B1KtbqCFYxNCHuFYThl2LUYfN6H1TCDB+r0JAEIv+67
   kBhXFzilM8rdkJVyPe7pSBsYOWDLXufOYx1BMH7Qyhv1V238El0D/G1sj
   20KbEqikhq3MTbyvB756hB8Bs9hhvru97Z2hZ03RZ12+0J6yYcYu1V3gK
   aekykIuDYpmDt1TniKWt0IbqafLTkaYD8Rz/2ndaUaiTwKPgMV+vJKl6V
   RXB9fKx6+LbRE+1k6tIq9KnZy7om46xbJLqxmGbvFSAVEtzChBOMnjTT0
   w==;
X-IronPort-AV: E=Sophos;i="5.99,239,1677513600"; 
   d="scan'208";a="229654008"
Received: from mail-sn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.40])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2023 12:34:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGAnuNXJ2n1eECJ1qQy55PwpTLuf9pBDSJHJyDyoez+wtRppYKsvV+cWtnp4wvqeSXy0YJ4r66y7DUO2wKdPkgm8VKQQ5yRBVFIqcXolbhfDQ3bb3LSj4FxhX8pMtudlMDH9dtNYr5dMR/jXBWge+2jfnYK6O3ro5DI2jC8zWWgKR2HLgvUHt6ped+zGpJ9Q29c18K9Dr+6Ri+X/uFcSUneR1am5TMSM9jCl6VX8UMWyC4BJYdRlK2LKG08hsVmNORqnXHCvhmzMakKstEDgzdJFI/iYuRlXw/80wZSvdRUaCOegbNrrBTk9unb9NMtv8l5y/4Ny/r1IfDjy1lCf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSSf2HRB6tmIYfRDpb41X5aiaU9CuRCCwnsBPLUWYOE=;
 b=S0SXtyE52gAg8QlrPcWhdbNv+DkrxpmlbSQ64TmeLoHQLaSV2sX1iaD08E34OQSaaogWNlP3zwcqm7l7uRn2a4uZ1JJG7uMaTfWnU3uRfcpdnqIsEDQ1qSUY8sKG9+MhVcCh1aYXsPbwV/XAQ71l7oYW3CvtHDUGwJ/ATRLTTnIs99HF35mTei4ecwyH4pTSM+R2TKduPht0+1H9BGPpd2PGFfTEMLAdy/DcQCR/HkT4ZnhOwjp4K6hBFz0Dhx77AF/44Q8a5ABkNg+O9bfLxlIkw8TYEYiDooCUyahsxzwHCKG8fOal/73v0Eo+VszRVSnmC3HKkv3/a2msLzv6ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSSf2HRB6tmIYfRDpb41X5aiaU9CuRCCwnsBPLUWYOE=;
 b=BhR6jGSRCb1HFN29YTG6qQTB13KSAk4qL6mzjLXJh2XmcHF0IcpMVrLI3om/LDe+ds14x3mCbIdXx6Oi0FXkntv7v9AgLF2o6YR8hp/oVI0+bYOvX20RnR8xMQIS95so7KTOG1mMEctgq483UNTRDx/Fqut/dVG9bDeFFbv1nPw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6994.namprd04.prod.outlook.com (2603:10b6:a03:228::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 04:34:39 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 04:34:38 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
CC:     "shinichiro@fastmail.com" <shinichiro@fastmail.com>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH blktests v2] tests/dm: add a regression test
Thread-Topic: [PATCH blktests v2] tests/dm: add a regression test
Thread-Index: AQHZe+Y9jbQxdYN1K02JKjkDsq86Uw==
Date:   Mon, 1 May 2023 04:34:38 +0000
Message-ID: <2lsxdy3n7vfwtmyubfc7kh7yd6mxrht6nlnhmvwzrsellij3kc@5hctf5lvmr6e>
References: <20230427024126.1417646-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230427024126.1417646-1-yukuai1@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6994:EE_
x-ms-office365-filtering-correlation-id: d0fc3e4c-a61e-42bb-e530-08db49fd5fd1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MxXtLrIqUTQ7Mziv5GT/n9PZc4JqvcV0xgDiW+ZAW/0LNIy6OTXmHVYQclOpdc494WLMd/xu5v17oRe5U945xJTe70bPGyodmneiN7B9MoHZYlJVZmf5MqlbEhaaL3qjZCBJTW4k/kBGJHrfL0vLx+g26V37/j4VaP9cw1wXRdSKJhuFrJZ2hgCUrl3w6iDz+uZQ/Rj5A9gyHu/m2qnTfeRvZDfuzEWr3Eag7d4IqLAGXLFEqk5qt4ijvJj9v+3Clp4d4BSOj809EsVOQw5tn+ZOCJUPmvsvSa00Lt3fVAUpeac1wEJX+zCZQhtt+VgnRSppGkiecck2bUUF3wAoED6eJ5MvKlyHzwHEhMFoZqnYoP54enkS3e6cuBJo5I2VbbkHFdACd+LF4kpbZ50g0ZO3aIO2+m26mYJ+kWxkXF60XhXqqNqHd5nPYEvsIAKrLijXq1sVSKK9lOoP6Ej6xJoZgECfOdLj5IayQu2tz7Zx6BhQ8xgxJAYB4uNpYstV3HOTrSv9AMTwejUsVhfT710oW5VQuMEj8dZXMoCCcFPJnwi4eFvGrFpxsdte977rQ2Bo7Vc1xEE8lf2KR6zfBN+A0VsxcI8d+8anU+WvVUnsrqbCNVsQD5NpYKaTeozt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(346002)(366004)(396003)(39850400004)(136003)(451199021)(6506007)(6512007)(9686003)(186003)(26005)(2906002)(83380400001)(44832011)(33716001)(6486002)(5660300002)(71200400001)(478600001)(38100700002)(82960400001)(8676002)(8936002)(122000001)(38070700005)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(76116006)(66946007)(91956017)(86362001)(41300700001)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ih8sdMQvq0SI7g3BPD+NoNVWF5YOyZFHa+EubagdCqvGTi5tSQACd0e5D4FU?=
 =?us-ascii?Q?hnIGS4bJpKdNLFgw3VcIQe5fzniY+LTQMkeOccHYxhHzkQboxAkkp5WpiG7j?=
 =?us-ascii?Q?CnvjQ+ST6K1o6cxM6m3VW+daeUfPDPfsr4sRYOZ9OfhZ+2DdfEOH+9usqtat?=
 =?us-ascii?Q?NCws07SlwFri3RTLpwPWd7O8xKaSZyHpTyE9gX0dxRShmklT6H+n6kxX/Kmd?=
 =?us-ascii?Q?wbzqlfx48/duVyd0rM+/mAIu8Nv2ZaJ+/WDly0WGIwmrgNFrUBa5mnZmdCla?=
 =?us-ascii?Q?J4yXPDRi6V7OrkiPoYaSpKBzO3B0lKt/IhDFuef+oi9/c5be9lFM7JPVo16v?=
 =?us-ascii?Q?G+0KC5EQ/BZPAEOKhm9Vet3+siels2DYem1NiGkUkU3bazHx2WlaxbF3K9sT?=
 =?us-ascii?Q?Z9NaRPaCcfv4z9hx3NtgObXF2mrq26ZEKMUle+sDBl727MPxQp+O6k/7Coz4?=
 =?us-ascii?Q?GPQRqAAXXGjhB7Xol5VHNwv9/DyFQxfeGCxAhWP/MF52MXXhr0VsUoYYnx6P?=
 =?us-ascii?Q?NMCMFifCADvbKzTY9iTcKbSQYnF/+YtX/XFF4Y1wNGpWQ/xLliyBA16V6MtF?=
 =?us-ascii?Q?ul8Hg4RYtt69GAQzZgpIKiFs8y5sg8kqz3BV9EW9PITg005kRU79JfJ5ugj8?=
 =?us-ascii?Q?6qQg2PKUphcLIig9fb8GxQvf6brLTH4PIkSWnZQK0dfQyvHjkhIbe1YNBkoz?=
 =?us-ascii?Q?Us0/myTSRGz/w9hAHMAN7bc0oG/4ZHQhuN9tbkU2vWFU6/cB4uug+m+3n6To?=
 =?us-ascii?Q?QoCmf3vJL6Pcxa8rYp8VBSKmIwNUe6FDuNbjlvHbssVrOmQ+oAx+094cBDSj?=
 =?us-ascii?Q?qbKGyDgAKqRvOPm7UeNd+zSLbgi0YRefTKkga7+i11JHw5nvaZRSbr8x0Ofi?=
 =?us-ascii?Q?+Ap2nPfTPV63DT5bXmmA6iQPQ4mlvZKoAMfFs0nMCcnjszsFLodF5qRNg8Jj?=
 =?us-ascii?Q?qsnR2YQ/svbr+w/hYoz1ImYJRz3woDKJNvpaD3mQFTfkxhggHlx2I8VkuAlk?=
 =?us-ascii?Q?W0ewelcs9XnPPA/VsihrdKjP3XDpOsZjXi0BxvvNd64QyK4axjT2rJF22ZXi?=
 =?us-ascii?Q?AgAaU55Pew5eAWWlAMQ9FF+RpHdih+175HUowgqqRdD8BJTwF2TOOr4oGPqw?=
 =?us-ascii?Q?kXrdkJ1a8Sd8IyikMm3o1WF1CzEB/Zz6VPMajTFNdcV1diqEDT0lkYI5ELWD?=
 =?us-ascii?Q?JX1w7+PvWeQwuqK6bnM6mJKWL1VaG+uOv7a2S/CbH+YZjvil0amFIk88jsGL?=
 =?us-ascii?Q?kfS7w0LrgVbbwRN62zRTVWOrVFXzl9tnEY31CqpWUg3v/Ekt7AwtDMf0pPDY?=
 =?us-ascii?Q?VbdqTOs4HTYwMGWtfzS2aHGussGeUKowUGXdILTSFvcBYo+1K0l6flvIwW2s?=
 =?us-ascii?Q?FzRMUAobrs2I6FacLCP6vGGXd9pioJPLO2XCv3vdKzQC8J7skdlfO7lDixlx?=
 =?us-ascii?Q?Q4oePmth790aDqQkuEvAZJVhxXcLbCnGeSi2vya0QT4uIrtDmTq+vBLsnd8w?=
 =?us-ascii?Q?CQd4qbdgwaYEZiN4+0fy9D1xDV9WJHgMv6yuBpAGGSULGn8XBixi5hJW+W+7?=
 =?us-ascii?Q?MZXdDfBKEtyGIg0v2hOblLbzdGOG1eySGH2cIODV4M8rvc7wlgSJWSpVVtQn?=
 =?us-ascii?Q?mcjOJhgQO0glEDOt0FR+w18=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4546ABCB44D6C747B617434FAF07F48C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: C5rESEKIQBBmqVSr4M2N3Q2puddSO4L5Rh8uVH8dC3QG/TE5HGeuwqcDZBPLfmnmt5QqAw1ZnZEo38Hvd/yGarLsljOMii/v3eDV4mNcCYklkJePhg7aAw5To1JqFKu4m0WPF8IK6Djxo9hdhZ+3mJa+bJpfmkAWQJ/JvCQ5beC3JCUehXX/T2q1LN4x2HHvKz8GKKJJ7c5XtuE5rh6Moz3lgSE1UoHT1M/eG/vTt5cJ4sqJbPWHEytEaGErLAYBfsx5OUQvdECJ/BtEFuylBrP1em4WPLoATeoMawwHhW8CzDI9whjA1MmKmcENLAe5KEFCkB+Sce5/RTXY2eMX+QGLjh9dSdXvuKFob6FHJbGjmlgrZzJ7TOY03MxfYlyDRplqLdHlRr8CfMV9n2KOvmutPQWPJRt6fKiwc8PQvxXZo2RsXWe02V29DuJeeAF4aDud/xrnE02iu/yaT11rzEz44+xCRZiETyjsft51oA5ktWC0NUGWTVqloonDcGp/rj4HyRLsxkmjrIieRdTMBAN+zJQJT94/kF72j+2o2X4O+LZu+TYRxL8xY248uPJn3uARazpvAc4XHg88O4ON/9FN+oNYYY2Cxj+TzgczOU1iUSu+/Yoa6vEvJS/qQeL0NNiLXf3bysOaigGqFzzOaOWN4y1SOpLbE1mrx6LFiAgQAuYqoGTb3ymhFHaaVJ65KTL+rQTqg8rd4pz5Nybr5oFWpFMFv0fMT26fu/XvHx3lnSEtIjrLDm6mM7Myc3LCVy/P0CCBKqN6bYpRljLlWPwwSsPOsvuyEqQ9DTkAtsL0i6bn1iTSlG+4Sw63foVFatCqV4bCrJqZS3IefKdy0tHAuu9QyWHOSuTdbLTaHDDfwrdglOeG4beMdyQ1WSEVURZqBNaQMwOO66t3Gi2PrbKiuM5SyajRo/U+tiuLUPM=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fc3e4c-a61e-42bb-e530-08db49fd5fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2023 04:34:38.6165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyMV4okGme0XNZAEZ67adQrWPFpDCNsKvZZFVBZfRD2j97o83jO2OuMDCmTxBUx17smpuc9kar5XVa/iM01WF+Ujo5PDnKUGNe04VuWAOj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6994
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yu, thanks for the patch. I have three minor comments below. Other than tha=
t,
the patch looks good to me. If you do not mind, I can do these edits. Pleas=
e let
me know your thoughts.

1) Let's describe a bit more in the commit title, like,
   "tests/dm: add dm test group and a test for self-map"
2) From historical reason, we add executable mode to the test script files.
   Let's add the file mode 755 to the tests/dm/001 file.
3) Please run "make check" to find script issues. With the command, shellch=
eck
   reports a warning:

   tests/dm/001:23:7: note: Check exit code directly with e.g. 'if mycmd;',=
 not indirectly
   with $?. [SC2181]

A hunk below will avoid the warning.

diff --git a/tests/dm/001 b/tests/dm/001
index 09731d8..f69f30f 100644
--- a/tests/dm/001
+++ b/tests/dm/001
@@ -19,8 +19,8 @@ test_device() {
=20
 	dmsetup create test --table "0 8192 linear ${TEST_DEV} 0"
 	dmsetup suspend test
-	dmsetup reload test --table "0 8192 linear /dev/mapper/test 0" &> /dev/nu=
ll
-	if [ $? -eq 0 ]; then
+	if dmsetup reload test --table "0 8192 linear /dev/mapper/test 0" \
+	   &> /dev/null; then
 		echo "reload a dm with maps to itself succeed."
 	fi
 	dmsetup remove test
