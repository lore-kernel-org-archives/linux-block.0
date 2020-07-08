Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D574C433DF
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 14:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54BD720786
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 14:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rZEp3+FN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eYRKPE/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgGHOXH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:23:07 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:43309 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729699AbgGHOXH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 10:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594218187; x=1625754187;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FGJvXQQoEyog/UySIErVEHHFYmimmlCeZ1CCZ776lYA=;
  b=rZEp3+FNN4DlS0PDYw1wyeZzklunT8DRYo4t6j9gm9U8NOMAAi5NASyT
   kOx0pnWz6ezxnw+jdHKOckPNk/WSGW35an0Re76+l18/l22K0RfM6XkxY
   lnwlZ3An8Kw6s0L8f/hcvRqkIdFzyQCSAUK0mw0fG6Hvx4WzOhRDInNlZ
   TWqKXPbz5Gv4mZ15yzbt+NY5IIn3Y0HJ92P7K2NH9YlK8Z2Nw1HBIfdPN
   /3y6dOOle566oGy7EwVlRI32PChDwTtzKIsmINe98LrZZUZXUi2TbmoK/
   AWFPPhpzWOew8JPtSos2sQjjNqXP4RqJswGZu2eaJOim8lbaVlg7F6K4x
   w==;
IronPort-SDR: p5GJau7/HhWeDhyc1tWlWaZg7pqJrFfy7peJFyumqhYrID4V8Fe9aZdJrpWtXVxqhL5UfgwIV9
 JM1oIi0734OuEsxRT67IADKRRVTtifqtrL1XHidWpioN8fVJFKkuGrVoefglZXop8dBpKEqWGb
 Aar2GwB5O6YDBKnt2RXIQ2ar7OKIqxetwsImFekqxR1an8Cv0uMDVaYDJ9SjWB+qwB65ILz6HY
 t3kU6tuPb0qEZ7n/3VtJdCfJa5SlaRZG8AD+6ACfxkn/hFGiqUppkfopxKWiTPvxjwsCQprq+H
 ni8=
X-IronPort-AV: E=Sophos;i="5.75,327,1589212800"; 
   d="scan'208";a="142100228"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2020 22:23:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMI3WbGInem+d3DvIagYDR2P2smnKUTO0xoOSVksbyIobHubDk7LNM7Dp9mNK950D3GhgInoUjNxoP58l+aS4av5RluG6kIKslJ+CFyZv7j0MttHDzy4zTJUDAs3Pgrf+HbDI7qkOuFNFYogZzCDwC1+PmXSe1yn7ydfHuaSx8o3zH7Oz8VhP7Ql1dMUBMN173UrQMwWT4mIRzAhGroeR02AMGglGxrHp865vqTSVmg4YL5Zv0YIYmWIpxcU9IAr7Um6y3gtC6+FWrAWeq67OjdVIrhCdUDPaK3nokYTGET8JERSnTqphXy0jUKQJSC0xrK5MBKogHQPgLWuPqdGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUjdRSy6Vcwtya6On9823hFWKcOT5G8R+zTtGNUoLdE=;
 b=dQnQ0mumxJ/8pFkyenA8J8s1//06lBw/09ySkdxJNDqoriDxAyTKK+5SKA0sHnRx5MOSs4/ocQV5zjy1V9gjDe3nW1EPA+6mdwfX/ygzpuaCEKIF8gTt7D6ptoDr5oGjt5+L6Gisi8R4PPF6hksEhplJNwyqNj07RlJEk+kpFZEhO/dFjhYCFYDXSOL93qzku37vAWEqQcB9RaqH97ZK0c5ZXHy0HF0vn/+CD0dM9a407NQV0/ujJZc9EEBc7SInYkymkfI3BfJ6VNPpSZOOgTpXVp03piLXZ7Z6S8JGLJhwVIkKiNIjIEd1szAaxRV9vzOWL18UM29d/eHkyYzRFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUjdRSy6Vcwtya6On9823hFWKcOT5G8R+zTtGNUoLdE=;
 b=eYRKPE/nNAkGpaeQZhVNq+EmNGoomDH+n/lJgSHRozN10x+L38iltFHCWVNidGwcnEzAd3aTixEhGMyup1qmNEyXeuvZuBPLoJVRrIRZ5MF/2u4UuMDniB+Bm0uRgeTUQt/HVcvih1m2bwp6RItrOA+LzSBV1bmyLXqeehPlQFE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3679.namprd04.prod.outlook.com
 (2603:10b6:803:46::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 8 Jul
 2020 14:23:04 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3153.031; Wed, 8 Jul 2020
 14:23:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     John Garry <john.garry@huawei.com>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH V2] blk-mq: streamline handling of q->mq_ops->queue_rq
 result
Thread-Topic: [PATCH V2] blk-mq: streamline handling of q->mq_ops->queue_rq
 result
Thread-Index: AQHWT6/PEqZpUhXEo0yHHoBVF2I1eQ==
Date:   Wed, 8 Jul 2020 14:23:03 +0000
Message-ID: <SN4PR0401MB3598989A917B1658D64A2F539B670@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200701135857.2445459-1-ming.lei@redhat.com>
 <20200708122749.GA3340386@T590>
 <90d57d37-6da9-cae4-55b0-264c3dd885b0@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2a00:20:5024:a510:31:29:8357:2279]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76272cdf-a6a0-46c9-2d37-08d8234a6d40
x-ms-traffictypediagnostic: SN4PR0401MB3679:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <SN4PR0401MB36795027FD223B027EAD19589B670@SN4PR0401MB3679.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eHcoJrWu32LDjM55jtQEbWit00KekINgNBb2LPritnZwYEEhJej86UhWkrhjhCCt7GW2L6lma3m69Szp4JeTxt5xqLbnzOiZRxHQ51JOx9HcbNDWSRV3GVMQDUcFp8MaFCBmM6p9U54YJr9+wia4tEHxK4CDPTWV9MtiS84pYk+hyWqAgvk7/IV41SJiHXulJFkoD7KzmGuhg6fduu4CGS1xXRzB9fgzVVbqtPpR//jtiTeO9efpS2YTwcOblPiHWJvQ1XSArJ9PBkCg7WfB9UoVDqkK9EhrKScffcIwUndT00QWP1RP24At0zg1Wjyy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(8936002)(2906002)(52536014)(53546011)(83380400001)(66946007)(4326008)(5660300002)(6506007)(9686003)(8676002)(316002)(110136005)(55016002)(54906003)(478600001)(66556008)(66476007)(186003)(66446008)(64756008)(33656002)(71200400001)(7696005)(86362001)(4744005)(91956017)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: TvpWWlsCfUf3ZXrrGmGLE5oE3F10bPTV9VxspRMPbm4kbycJduOT7fdo3xzlI8eXYWawJTRJ4fd7D4IeslYkDs0ss3lhnMuRfXPLpOzUq4094GzTz5K3PSxqUujKnoZMf4WxEp3B89ncOoZPWE0bJ9QsVcZjn3FN45TJqszIyQrxMzd57x4SeN+asCiQK/I7bLwxYWO2hkcFaaDUXE9vmfGb9sjoZABwaU3M7JPkskJtpI5iFYWh8T2pq8LcljEZp4uJyMR2heMga+WqqN7Z2ZJpJl/lAt8smfkTGslJfBZrzRlixUa9qcgcCiUOi8LRDqjDRjWa8ccSID0JBAhYKBtAbkM40HaAiOtp3cUSV8woHE6YrNgsCNSZDA/gTO+gTc5nsSOAnE9cHXPYug5PyHUDdFPdvF1yGtZp3y5n4d9GgyEEOlLgEu08DeyGwwdMNeN3oGh8xXmlQd9uZ6XiWdMw8Q2ZgecMllluG9gXnWgJjCQoM8hp5v3u6GxPZwRPNlvJvyyruqlTzeZrKHfh//AsF5L0RueGn4mLsjneKzE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76272cdf-a6a0-46c9-2d37-08d8234a6d40
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 14:23:03.9596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5+RKMw/5gIzmg4FMGIwHM8SnBYvT3k3kmGlNFpGMFC/u+bTlx5UocJV9El4KmWWYkJPyYHRC723+9jpi+iPK9ELS8jixTRXcVxkZiaVMiOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3679
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/07/2020 16:06, John Garry wrote:=0A=
> On 08/07/2020 13:27, Ming Lei wrote:=0A=
>> k;=0A=
>> -		} else if (ret =3D=3D BLK_STS_ZONE_RESOURCE) {=0A=
>> +		case BLK_STS_RESOURCE:=0A=
>> +		case BLK_STS_DEV_RESOURCE:=0A=
>> +			blk_mq_handle_dev_resource(rq, list);=0A=
>> +			goto out;=0A=
>> +		case BLK_STS_ZONE_RESOURCE:=0A=
>>   			/*=0A=
>>   			 * Move the request to zone_list and keep going through=0A=
>>   			 * the dispatch list to find more requests the drive can=0A=
> =0A=
> question not on this patch specifically: is this supposed to be =0A=
> "driver", and not "drive"? "driver" is mentioned earlier in the function=
=0A=
=0A=
No it's drive, the sole purpose of BLK_STS_ZONE_RESOURCE is the apply some =
back =0A=
pressure for IO submitters to a SMR disk and the zone-append emulation it u=
ses.=0A=
See drivers/scsi/sd_zbc.c for details.=0A=
