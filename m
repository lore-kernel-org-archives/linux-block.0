Return-Path: <SRS0=2qaK=TK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537D5C04A6B
	for <linux-block@archiver.kernel.org>; Fri, 10 May 2019 18:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A108217F4
	for <linux-block@archiver.kernel.org>; Fri, 10 May 2019 18:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gi9dXtLT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="it8otkeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfEJSU0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 May 2019 14:20:26 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21586 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfEJSU0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 May 2019 14:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557512426; x=1589048426;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XTE/aF6+Bu7tXa+2c1CPNvxgOH5Q/r1j5n1cYFNWSS8=;
  b=gi9dXtLTGz+rCHSCa5RCZP3f+4GKaYK0qXfvw0jz4OvEhDVTD9JsNhxm
   cBC58fUzt7UTuxpYmdwQqSfo5L3yEx0H/KMohy6gtKBzB3w3gkFQG7rS6
   IVLvsDyQwxHJQAZ/PRSUUf5AlEGkSPmy1d3YJF4MEYYZ/NCf8ezkIPr5o
   s7MbBlMrNNm6MYIP3J90ezHx4TvpaiV04AC7WSe8DMZXl+OOIQ0a5NAUg
   vj8F2otvmqZDEhSB5HsccujZ1hwaSPFVcsSwodMog1qrCJL8jsHfDXsfr
   cHg8SJz0YoPBc4wHI/8eZYugiTeM45CW+vSztzLFO7euIf3Z6tccP64Sm
   w==;
X-IronPort-AV: E=Sophos;i="5.60,454,1549900800"; 
   d="scan'208";a="112948119"
Received: from mail-by2nam03lp2054.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.54])
  by ob1.hgst.iphmx.com with ESMTP; 11 May 2019 02:20:25 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STQdqWmKPaJT1xQlvQUiAht9IZNbhiXSXWyAI5PwKSg=;
 b=it8otkeB1XqLGda6+WjoNZbiOscsgXXZfqewPHg7l5nOOPUT/Qh+qERYem4uYQjgcFGGXFzPjCgrJzeZy1qJ9dHTGo8OXPdbKucHITSIU3p9cfP6uboWffJlHRa7onYitXVNZr7LX6tjAi3IhoOadgiyBKPj5b1WsFWDyn25Ijo=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4414.namprd04.prod.outlook.com (52.135.72.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Fri, 10 May 2019 18:20:24 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1856.012; Fri, 10 May 2019
 18:20:24 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Xiao Liang <xiliang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH blktests] block/005,008: do exit if fio did not finish
 within timeout
Thread-Topic: [PATCH blktests] block/005,008: do exit if fio did not finish
 within timeout
Thread-Index: AQHVBJhqqZgI2MEGu0+c4h2gT/9InA==
Date:   Fri, 10 May 2019 18:20:24 +0000
Message-ID: <SN6PR04MB452783DFFB989FC0E4DE6455860C0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190507054721.6056-1-xiliang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d079d8fc-159d-444a-029d-08d6d5742bbd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4414;
x-ms-traffictypediagnostic: SN6PR04MB4414:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB441491DE0E6A9DD4F1F271E1860C0@SN6PR04MB4414.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(346002)(396003)(39860400002)(189003)(199004)(72206003)(6246003)(256004)(66066001)(71190400001)(2906002)(486006)(6116002)(86362001)(8676002)(53546011)(9686003)(478600001)(6506007)(102836004)(53936002)(81166006)(81156014)(14454004)(2201001)(71200400001)(7696005)(66476007)(52536014)(26005)(66556008)(8936002)(73956011)(6436002)(7736002)(74316002)(76116006)(66446008)(305945005)(66946007)(2501003)(64756008)(91956017)(3846002)(229853002)(68736007)(186003)(316002)(110136005)(76176011)(5660300002)(476003)(446003)(25786009)(55016002)(99286004)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4414;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ATroHC01TQ0v1Ba6uI9+v0vjYZQajfavXdQB8yKeI4VEspIpANL3y/sP2Scrm6qQKeRHw5lcp7eUzbkGGuTXqIEspaqyOEOxxDAEjxYuPJw73fqSNO6vH76a4ED9BeugRPGy9TaxscTQ0TsNPZWP31t/YXBFkfhb+NR7luljnV14XjUm0q4wTuNQp+5q4duDVAJuj8wIHh5ShUwRP+jvvQs0JGnYAmIRGWojDOjuA1G0I2iHZiCTJMZXfNCZdfkh3fmL5h9LIFo8E8y0Ifb/UKBBJUlk9ZfbrAO4eA9cv9WPtyBettCsq7S4Dpvix3XVitBQDGtQRm+gZzDKFPd24aJ6/tBytjriM0JmK0rSqxZKx6srafwrgC8CL2FAFTC0un98ZPWqLEFRKDjBcAfmRvzY4+zTh/k+ZIxunvRQL+g=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d079d8fc-159d-444a-029d-08d6d5742bbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 18:20:24.4622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4414
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Xiao,=0A=
=0A=
I like to idea of not blocking the other tests. Couple of comments below.=
=0A=
=0A=
On 05/06/2019 10:47 PM, Xiao Liang wrote:=0A=
> In some bad situation, fio needs taking over several hours to complete=0A=
> random read operations with specipied size. The test may skip out in such=
=0A=
> cases and does not block other cases run.=0A=
s/specipied/specified/=0A=
>=0A=
> With this patch, the case will be ended within $TIMEOUT(if set) or 900s.=
=0A=
> block/005 =3D> nvme1n1 (switch schedulers while doing IO)      [failed]=
=0A=
>      runtime      ...  1800.477s=0A=
>      read iops    ...=0A=
>      --- tests/block/005.out	2019-03-31 14:29:39.905449312 +0000=0A=
>      +++ /home/ec2-user/blktests/results/nvme1n1/block/005.out.bad	2019-0=
5-07 04:10:16.026681842 +0000=0A=
>      @@ -1,2 +1,4 @@=0A=
>       Running block/005=0A=
>      +fio did not finish after 900 seconds which probably caused by=0A=
>      +lower disk performance=0A=
>       Test complete=0A=
>=0A=
> Signed-off-by: Xiao Liang <xiliang@redhat.com>=0A=
> ---=0A=
>   tests/block/005 | 10 ++++++++++=0A=
>   tests/block/008 | 10 ++++++++++=0A=
>   2 files changed, 20 insertions(+)=0A=
>=0A=
> diff --git a/tests/block/005 b/tests/block/005=0A=
> index 8ab6791..96b16a4 100755=0A=
> --- a/tests/block/005=0A=
> +++ b/tests/block/005=0A=
> @@ -31,10 +31,20 @@ test_device() {=0A=
>   	_run_fio_rand_io --filename=3D"$TEST_DEV" --size=3D"$size" &=0A=
>=0A=
>   	# while job is running, switch between schedulers=0A=
> +	# fio test may take too long time to complete read/write in special siz=
e on some bad=0A=
> +	# performance disks. Set a timeout here which does not block overall te=
st.=0A=
> +	start_time=3D$(date +%s)=0A=
> +	timeout=3D${TIMEOUT:=3D900}=0A=
>   	while kill -0 $! 2>/dev/null; do=0A=
>   		idx=3D$((RANDOM % ${#scheds[@]}))=0A=
>   		_test_dev_queue_set scheduler "${scheds[$idx]}"=0A=
>   		sleep .2=0A=
> +		end_time=3D$(date +%s)=0A=
> +		if (( end_time - start_time > timeout )); then=0A=
> +			echo "fio did not finish after $timeout seconds which probably caused=
 by=0A=
> +lower disk performance"=0A=
Can we make this message more generic instead of calling out disk =0A=
performance ?=0A=
> +			break=0A=
> +		fi=0A=
>   	done=0A=
>=0A=
>   	FIO_PERF_FIELDS=3D("read iops")=0A=
> diff --git a/tests/block/008 b/tests/block/008=0A=
> index 4a88056..c25b908 100755=0A=
> --- a/tests/block/008=0A=
> +++ b/tests/block/008=0A=
> @@ -45,6 +45,10 @@ test_device() {=0A=
>   	done=0A=
>=0A=
>   	# while job is running, hotplug CPUs=0A=
> +	# fio test may take too long time to complete read/write in special siz=
e on some bad=0A=
> +	# performance disks. Set a timeout here which does not block overall te=
st.=0A=
> +	start_time=3D$(date +%s)=0A=
> +	timeout=3D${TIMEOUT:=3D900}=0A=
>   	while sleep .2; kill -0 $! 2> /dev/null; do=0A=
>   		if (( offlining && ${#offline_cpus[@]} =3D=3D max_offline )); then=0A=
>   			offlining=3D0=0A=
> @@ -65,6 +69,12 @@ test_device() {=0A=
>   			unset offline_cpus["$idx"]=0A=
>   			offline_cpus=3D("${offline_cpus[@]}")=0A=
>   		fi=0A=
> +		end_time=3D$(date +%s)=0A=
> +		if (( end_time - start_time > timeout )); then=0A=
> +			echo "fio did not finish after $timeout seconds which probably caused=
 by=0A=
> +lower disk performance"=0A=
Same here.=0A=
> +			break=0A=
> +		fi=0A=
>   	done=0A=
>=0A=
>   	FIO_PERF_FIELDS=3D("read iops")=0A=
>=0A=
=0A=
