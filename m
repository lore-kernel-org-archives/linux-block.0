Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F363C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 10:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033762148E
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 10:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h4QQYSze";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QGkeUzuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfA1KNy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:13:54 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:60661 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfA1KNy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 05:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548670434; x=1580206434;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=klfA9RDhA3+jC6wXe+/jgIVA2AWMW7XYtKvj57MEpQY=;
  b=h4QQYSzeUJKnQ6I0ca9GIjCuC0qwl9Ot4Dzap1YH50KqapieTTW6TlYU
   uN5E+dXXfS7F3ib6GeLkki7GPmEpEbduS6NsGVNQbbGzG3vwwjugtySeT
   9JH4glMbx2hGwYcuiMaVfnwWDlfhWHVtJtB1nJe5dm9lBWZHaDjTvV7lI
   pRatg2NKPfd/9YsYibLTkmIlLMXxK2nn3mOkASL89XoyL9smug68rN/Da
   tmSM/9AEtd1w+w63CdvYgtsBJ+lH8EWuSt5uIhpC9Mc362YXsWBFN6AzM
   gw2biOa4GNyiZvGMTn8fLRqmIw+VHRgEo8zuk9qrsRWTM84ZbhhnPtN6P
   A==;
X-IronPort-AV: E=Sophos;i="5.56,533,1539619200"; 
   d="scan'208";a="101698557"
Received: from mail-dm3nam05lp2058.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.58])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2019 18:13:53 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JqM5s+9iMuEX76oVFaT9XfnqqJCrIky6CId6tKKfX4=;
 b=QGkeUzuDyhs+b5bPC5JfPdOLQ3B0Lv9AVU5iTrTkLAZV7qtoorstlTw2e7SD3i3bne1s96+n3RkEexkPnIrr7WBCT35owy3r2T+nmr+mrH1essKwGoEtawz8HU5dUH2ZIR/8QmzBoQwbUutrOZQLXM9XFiNeg3GWLNRm+VEmjE4=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (10.167.9.7) by
 CY1PR04MB2346.namprd04.prod.outlook.com (10.167.9.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Mon, 28 Jan 2019 10:13:51 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::9431:bb6e:5c5f:ca67]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::9431:bb6e:5c5f:ca67%6]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 10:13:51 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH blktests v3 03/13] block/004: Adjust fio conditions for
 zoned block devices
Thread-Topic: [PATCH blktests v3 03/13] block/004: Adjust fio conditions for
 zoned block devices
Thread-Index: AQHUrxKEFJzzrwIHGEy60VcGTV8O8g==
Date:   Mon, 28 Jan 2019 10:13:51 +0000
Message-ID: <CY1PR04MB2268DDF26D6633533F7F34F4ED960@CY1PR04MB2268.namprd04.prod.outlook.com>
References: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
 <20190118094453.13773-4-shinichiro.kawasaki@wdc.com>
 <20190125210901.GB26739@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR04MB2346;6:EwLGehzULzWFDts5WxfT7zthE7tuM4zxAPMmFM3B1QS8EZe7ZzzwRswulnEWpaCrKSUSNu7pA5352uEMbNE2F9eHl5pjE2h04KHazGh1BFC2W18AqZZKkmdGw6tfiSbOlkzPOru+ch8UFX2crSuT1Smsh4TKQJ3dHvRnHS7sXJ5L+zIn0v9kn7NbPUiHUTW8Aek4SydEIiPIbprWg+/9OWJZWCWFfU2v+/MWo+OYhynO0hbrupWqpHPhdRkLGt6Np/HwvluilLllIWoOOb918crpKj22JG1JIHC5JWYzm421UBYMVMYVorD8d9whLLtnwN3/d/vguGWzbgvema4pp790PIWOS14C4bsmtuadqW4+9XUWAu+bNAzfP/7R2n3GoavfwsJh49eX/SPoh4lDc+o4ALV+dD1cWoX9Ne53MqvKIowfaxybuY4JJ1J9kSo6aQZ0TQB+/DQ585fsFxVsgw==;5:tquoQocxdUAxVJ4gsqGRhoNrqiUHlbXsZWnSJUQscF70qigoB4NXjk98Enioi+pqmAYGMxjmgZmQkCXZxM622kWknRiIUaPk/+qXwYoK5QLDEf6Xf/ZYZtVVipKgIMtoIlJVMpov6dEAiGge8DHjcV0Pp57m0t7rqliliUyOAdI6q3ofRMJIfVZKkfOI/jK5AGS9JTXbmblc92z0TFo4OA==;7:wCf9T0jXHhxiWcMqS523S/HgnU4nmtowbHFmdFvxx47l2csygyxH35kJ5iQECytubUIZmPSvQXio5cFlmXjDRrogtTSPDx+VK1wdxgKccMKRIMLkkI/Z5bbn04F/ATnE8YndxMCv/4lFcnkKwmqGjQ==
x-ms-office365-filtering-correlation-id: b7511a36-e15d-47b4-2b2e-08d685094d5a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR04MB2346;
x-ms-traffictypediagnostic: CY1PR04MB2346:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR04MB23464477F177E51B40D6678BED960@CY1PR04MB2346.namprd04.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39860400002)(136003)(396003)(189003)(199004)(81166006)(44832011)(81156014)(3846002)(4326008)(102836004)(8676002)(25786009)(476003)(7736002)(305945005)(6506007)(53546011)(478600001)(7696005)(486006)(53936002)(99286004)(2906002)(6116002)(86362001)(26005)(186003)(229853002)(33656002)(66066001)(8936002)(6916009)(316002)(74316002)(55016002)(9686003)(54906003)(105586002)(76176011)(6246003)(106356001)(97736004)(14444005)(256004)(14454004)(71190400001)(71200400001)(68736007)(6436002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2346;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q9USxT1rnIk2rPu9QGLVW63T+u420nNINLurdcj2sw/ePOiOeKPONt0KWAc/gSqLaSKiU4LzXGyExExiatQYM5LtzmLmJFbZwXPK0p7z2kbSVuC98EJ2YA8L9Z1b2cGOO1yyGwZPT1R5SjsUYGxzhNl06hTCILZdXIH7VTCDnbe6Pde5ytbM364ufrLCKm/V6PPAWc+pZSinlWOGPR45bSzryCsKam2fHOxR2T31aTCtmsI6yPq3eh7ZqZSnbGLNyUkoZU7V7OiqXewo3UnKmedyx7CAaPeZoxOP90dsRyTaJ8hoUmzjV+F4zgrwky6VDEqQaBwKvYpkgHkalYH2cfjOZn+wpK3NprSA19xESdke2lGVPgxdozCef8BWOcSuJvvSYlpl0HV+QsQUY5sbI5wAiEy5U4Kvbx+StYk0m9g=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7511a36-e15d-47b4-2b2e-08d685094d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 10:13:51.7667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2346
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/26/19 6:09 AM, Omar Sandoval wrote:=0A=
> On Fri, Jan 18, 2019 at 06:44:43PM +0900, Shin'ichiro Kawasaki wrote:=0A=
>> @@ -16,10 +17,25 @@ requires() {=0A=
>>   test_device() {=0A=
>>   	echo "Running ${TEST_NAME}"=0A=
>>   =0A=
>> +	local directio=3D""=0A=
>> +	local zbdmode=3D""=0A=
>> +=0A=
>> +	if _test_dev_is_zoned; then=0A=
>> +		if ! _have_fio_zbd_zonemode; then=0A=
>> +			echo "${SKIP_REASON}"=0A=
>> +			return 1=0A=
>> +		fi=0A=
> =0A=
> This will be marked as a failure instead of skipped. This check can be=0A=
> in device_requires instead:=0A=
> =0A=
> device_requires() {=0A=
> 	! _test_dev_is_zoned || _have_fio_zbd_zonemode=0A=
> }=0A=
=0A=
Thanks. Will change as suggested.=0A=
=0A=
>> +		_test_dev_queue_set scheduler deadline=0A=
>> +=0A=
>> +		directio=3D"--direct=3D1"=0A=
>> +		zbdmode=3D"--zonemode=3Dzbd"=0A=
>> +	fi=0A=
>> +=0A=
>>   	FIO_PERF_FIELDS=3D("write iops")=0A=
>>   	_fio_perf --bs=3D4k --rw=3Drandwrite --norandommap --fsync=3D1 \=0A=
>>   		--number_ios=3D256 --numjobs=3D64 --name=3Dflushes \=0A=
>> -		--filename=3D"$TEST_DEV"=0A=
>> +		${directio} ${zbdmode} --filename=3D"$TEST_DEV"=0A=
> =0A=
> I'm surprised that shellcheck is smart enough to see that directio and=0A=
> zbdmode are always one word so this doesn't need quotes :)=0A=
=0A=
Yes, and if I quote ${directio} and ${zbdmode}, fio fails with error messag=
e =0A=
"unable to open '' job file". I leave them without quotes.=0A=
=0A=
-- =0A=
Best Regards,=0A=
Shin'ichiro Kawasaki=0A=
