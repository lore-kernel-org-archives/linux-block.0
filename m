Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F248AC04EB8
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 05:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5B720851
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 05:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="td+0XYn3";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="mHKmZthp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5B720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeLLFaT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:30:19 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:43778 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726218AbeLLFaS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 00:30:18 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBC5Slar008810;
        Tue, 11 Dec 2018 21:29:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=viCnWdE/d4SY9EyVcp5mz64s5JE1ZYEp//25UnT+Bkw=;
 b=td+0XYn3JAI7ZfR9h7Yndiqe7dULbIJnXtVWEHbY/XHzz2uWAiximyAzW02o4AWZKq/+
 vYWJKcS5uCwGT2D27YgD67mxuoUIgwId2edYKZ3AFBv58I3rOSubhuUD3u2Syp6UbQYw
 PaMgurYgUhnHTiIdew6nws1mPf+noPK3fThF90dM8hbLQDtEiXdxhVsxOhO4OdM+BXVh
 5pIM1DLWu1FkDesgZR6BqK0+ej326mjUkCjjRTKvgTLtTacHTlRWr3+EtsQX74+AETpZ
 Emh8Vl9cx2DpAheAQJEjmTBPCwFfcsdgBDET1bDvsLqGsPv81+tT2Xx7OnvhRzC8C9rv 3A== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pthombar@cadence.com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2053.outbound.protection.outlook.com [104.47.48.53])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2p9wg8gnag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 11 Dec 2018 21:29:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viCnWdE/d4SY9EyVcp5mz64s5JE1ZYEp//25UnT+Bkw=;
 b=mHKmZthpY+NDLk3luPHWcqUAfxou+UOjHkKVRV6OmIvNe2j3ZCTIDZ6q/h1OXlKbqkjpGgAJNL9zSM7tmoBU7Paqx4+yglPi9XSJjLzOEDgEbM1c8z8nVUKCwchUep3nqjfO5H7Mbqf2ZeM03KbgBTFvdhiRWzF2zS7ssrVdTl0=
Received: from CO2PR07MB2469.namprd07.prod.outlook.com (10.166.200.139) by
 CO2PR07MB2680.namprd07.prod.outlook.com (10.166.213.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.23; Wed, 12 Dec 2018 05:29:54 +0000
Received: from CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::406a:f22b:dc72:d2e1]) by CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::406a:f22b:dc72:d2e1%9]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 05:29:54 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        Janek Kotas <jank@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>
Subject: RE: [PATCH 2/2] scsi: ufs: add inline crypto support to UFS HCD
Thread-Topic: [PATCH 2/2] scsi: ufs: add inline crypto support to UFS HCD
Thread-Index: AQHUkTcFn2oUaDSRF0KQyi683pox5qV5cKqAgAEd7vA=
Date:   Wed, 12 Dec 2018 05:29:54 +0000
Message-ID: <CO2PR07MB246947498D76D9A371A7E131C1A70@CO2PR07MB2469.namprd07.prod.outlook.com>
References: <20181211095027.GA3316@lvlogina.cadence.com>
 <20181211120337.GA3023@kroah.com>
In-Reply-To: <20181211120337.GA3023@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1mMTYzZjQ1NS1mZGNlLTExZTgtODRkZi0wNGQzYjAyNzc0NGFcYW1lLXRlc3RcZjE2M2Y0NTYtZmRjZS0xMWU4LTg0ZGYtMDRkM2IwMjc3NDRhYm9keS50eHQiIHN6PSI2ODA2IiB0PSIxMzE4OTA2NjE5MDAwNTk4MTgiIGg9IkVONlo3d0UwRjl1U1R3WXVDdlJjUm9hb3FwYz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [14.143.9.161]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2680;20:rsiR2kfydaLxEemqre0c9BHYouHOy9zu+7t1vfR4RkUrlNuKjfPwl+mMaH39STotcwSKGcyUal59AjNXg9FdNI34RN2tHGgKknI3WQ78cuA833OBnsgD6MLz2O0yWGLQZ/5nJa3QvrF207pjDi717ymD1A4yYqS8YRG0Zi6hziJpdkX5CyPdsrlaim1Ak9eSMkZ6PZWG5+sHgvtheSfUSwmNF8N6PWw0E2gHYKbYzQTr2GFltM8fFBSwLr/KWoUn
x-ms-office365-filtering-correlation-id: 0f3fdadc-6875-475f-0036-08d65ff2d8c0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2680;
x-ms-traffictypediagnostic: CO2PR07MB2680:
x-microsoft-antispam-prvs: <CO2PR07MB2680E5D9E99F2812108D56D1C1A70@CO2PR07MB2680.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231472)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CO2PR07MB2680;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB2680;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(346002)(366004)(36092001)(13464003)(199004)(189003)(5660300001)(3846002)(6436002)(76176011)(186003)(78486014)(86362001)(106356001)(102836004)(39060400002)(55016002)(26005)(25786009)(9686003)(305945005)(74316002)(14444005)(55236004)(7696005)(6116002)(53936002)(6506007)(14454004)(71190400001)(2906002)(478600001)(71200400001)(8936002)(229853002)(6246003)(11346002)(486006)(68736007)(446003)(7416002)(81166006)(4326008)(99286004)(476003)(6916009)(33656002)(345774005)(8676002)(316002)(81156014)(256004)(105586002)(54906003)(97736004)(66066001)(107886003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2680;H:CO2PR07MB2469.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: I0zD4oiX+sNB5zX97kziG8puGoc8RJRmVfIvoVXQIGVj9ASChO/IITXDdeK8ffuYhn8hWyTIQIFZEUeixeV1/1vqKx0vS/2VEebKnp8nH4qrXVG8ZZS7rP1Z8ntgdXTARQVtTzrhGx/GQYICjCc3qJ2HjZ24sIAQKFjqaWpfqbuO9GCMK4JrdIlPluL09817j3PIoBy5Z/2GqdQjIjrJTq5AB/GlM43Jzf36Y0S8IGErVXkSGraJ8DhvWrrzWRSiKPW0/MpzOq45vc7YILqgQd9wcCEwu9r8LAWe3iT3qssW/NUQmky0G8CVfT0LFhZf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3fdadc-6875-475f-0036-08d65ff2d8c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 05:29:54.1108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2680
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812120047
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Greg,

Thank you for comments.

>-----Original Message-----
>From: Greg KH <gregkh@linuxfoundation.org>
>Sent: Tuesday, December 11, 2018 5:34 PM
>To: Parshuram Raju Thombare <pthombar@cadence.com>
>Cc: axboe@kernel.dk; vinholikatti@gmail.com; jejb@linux.vnet.ibm.com;
>martin.petersen@oracle.com; mchehab+samsung@kernel.org;
>davem@davemloft.net; akpm@linux-foundation.org;
>nicolas.ferre@microchip.com; arnd@arndb.de; linux-kernel@vger.kernel.org;
>linux-block@vger.kernel.org; linux-scsi@vger.kernel.org; Alan Douglas
><adouglas@cadence.com>; Janek Kotas <jank@cadence.com>; Rafal Ciepiela
><rafalc@cadence.com>
>Subject: Re: [PATCH 2/2] scsi: ufs: add inline crypto support to UFS HCD
>
>EXTERNAL MAIL
>
>
>On Tue, Dec 11, 2018 at 09:50:27AM +0000, Parshuram Thombare wrote:
>> Add real time crypto support to UFS HCD using new device mapper
>> 'crypto-ufs'. dmsetup tool can be used to enable real time / inline
>> crypto support using device mapper 'crypt-ufs'.
>>
>> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
>
>As you cc:ed me, I'll provide some minor review comments:
>
>> +config BLK_DEV_HW_RT_ENCRYPTION
>> +	bool
>> +	depends on SCSI_UFSHCD_RT_ENCRYPTION
>> +	default n
>
>n is always the default, you never need to list that.
Ok,  I will remove it.
>
>> +
>>  source block/Kconfig.iosched
>> diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig index
>> 2ddbb26..09a3ec0 100644
>> --- a/drivers/scsi/ufs/Kconfig
>> +++ b/drivers/scsi/ufs/Kconfig
>> @@ -136,3 +136,15 @@ config SCSI_UFS_BSG
>>
>>  	  Select this if you need a bsg device node for your UFS controller.
>>  	  If unsure, say N.
>> +
>> +config SCSI_UFSHCD_RT_ENCRYPTION
>> +	bool "Universal Flash Storage Controller RT encryption support"
>> +	depends on SCSI_UFSHCD
>> +	default n
>
>Same here.
>
Ok,  I will remove it.
>> +	select BLK_DEV_HW_RT_ENCRYPTION if SCSI_UFSHCD_RT_ENCRYPTION
>> +	select BLK_DEV_DM if SCSI_UFSHCD_RT_ENCRYPTION
>> +	help
>> +	Universal Flash Storage Controller RT encryption support
>> +
>> +	Select this if you want to enable real time encryption on UFS controll=
er
>> +	If unsure, say N.
>
>Don't you need to indent the help lines?
>
Sorry, missed indentation check here. I will indent this.
>> +int ufshcd_crypto_init(struct ufs_hba *hba); void
>> +ufshcd_crypto_remove(struct ufs_hba *hba); void
>> +ufshcd_prepare_for_crypto(struct ufs_hba *hba, struct ufshcd_lrb
>> +*lrbp); #endif
>
>You need to provide inline functions for when your config option is not en=
abled
>here.
>
>That way you don't have to do this mess:
>
Do you mean empty inline function (which are exported) in #else  to avoid #=
ifdef=20
around each call for these functions ?
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index 86fe114..a96b038 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -47,6 +47,9 @@
>>  #include "unipro.h"
>>  #include "ufs-sysfs.h"
>>  #include "ufs_bsg.h"
>> +#ifdef CONFIG_SCSI_UFSHCD_RT_ENCRYPTION #include "ufshcd-crypto.h"
>> +#endif
>
>No need for #ifdefs in .c files at all.  Always include the .h file, and t=
hen since your
>functions are all inline void functions, the code just compiles away into =
nothing.
>
>
Ok,  I will remove it.
>>
>>  #define CREATE_TRACE_POINTS
>>  #include <trace/events/ufs.h>
>> @@ -2198,6 +2201,14 @@ static void ufshcd_prepare_req_desc_hdr(struct
>> ufshcd_lrb *lrbp,
>>
>>  	dword_0 =3D data_direction | (lrbp->command_type
>>  				<< UPIU_COMMAND_TYPE_OFFSET);
>> +#ifdef CONFIG_SCSI_UFSHCD_RT_ENCRYPTION
>> +	if (lrbp->cci >=3D 0) {
>> +		dword_0 |=3D (1 <<
>CRYPTO_UTP_REQ_DESC_DWORD0_CE_SHIFT);
>> +		dword_0 |=3D ((lrbp->cci <<
>CRYPTO_UTP_REQ_DESC_DWORD0_CCI_SHIFT)
>> +				&
>CRYPTO_UTP_REQ_DESC_DWORD0_CCI_MASK);
>> +	} else
>> +		dword_0 &=3D ~CRYPTO_UTP_REQ_DESC_DWORD0_CE_MASK;
>> +#endif
>
>Some comments on what this is trying to do here?
>
>
This is to enable encryption by setting CCI (crypto config index) and CE cr=
ypto enable bit.
I will add comment here.
>>  	if (lrbp->intr_cmd)
>>  		dword_0 |=3D UTP_REQ_DESC_INT_CMD;
>>
>> @@ -2462,6 +2473,12 @@ static int ufshcd_queuecommand(struct Scsi_Host
>*host, struct scsi_cmnd *cmd)
>>  	lrbp->intr_cmd =3D !ufshcd_is_intr_aggr_allowed(hba) ? true : false;
>>  	lrbp->req_abort_skip =3D false;
>>
>> +#ifdef CONFIG_SCSI_UFSHCD_RT_ENCRYPTION
>> +	lrbp->cci =3D -1;
>
>What does -1 mean?  You should have a type for it if it is something "spec=
ial".
>
-1 means crypto is not enabled or supported by hardware. I think this need =
a comment.
I will add it.
>> +	/* prepare block for crypto */
>> +	if (hba->capabilities & MASK_CRYPTO_SUPPORT)
>> +		ufshcd_prepare_for_crypto(hba, lrbp); #endif
>
>Again, no #ifdefs needed please.
>
>
Ok, I will remove it.
>>  	ufshcd_comp_scsi_upiu(hba, lrbp);
>>
>>  	err =3D ufshcd_map_sg(hba, lrbp);
>> @@ -8119,6 +8136,11 @@ void ufshcd_remove(struct ufs_hba *hba)
>>  	ufs_bsg_remove(hba);
>>  	ufs_sysfs_remove_nodes(hba->dev);
>>  	scsi_remove_host(hba->host);
>> +#ifdef CONFIG_SCSI_UFSHCD_RT_ENCRYPTION
>> +	if (hba->capabilities & MASK_CRYPTO_SUPPORT)
>> +		ufshcd_crypto_remove(hba);
>> +#endif
>
>Same ifdef here, and everywhere else in this file.
>
Ok, I will remove it.
>> --- a/drivers/scsi/ufs/ufshcd.h
>> +++ b/drivers/scsi/ufs/ufshcd.h
>> @@ -193,6 +193,9 @@ struct ufshcd_lrb {
>>  	ktime_t compl_time_stamp;
>>
>>  	bool req_abort_skip;
>> +#ifdef CONFIG_SCSI_UFSHCD_RT_ENCRYPTION
>> +	int cci;
>> +#endif
>
>No need for a #ifdef here.  But comment on exactly what "cci" means, that =
seems
>to not make any sense to me.
>
CCI is crypto config index / slot in UFS. I will add a comment here.
>>  };
>>
>>  /**
>> @@ -706,6 +709,9 @@ struct ufs_hba {
>>
>>  	struct device		bsg_dev;
>>  	struct request_queue	*bsg_queue;
>> +#ifdef CONFIG_SCSI_UFSHCD_RT_ENCRYPTION
>> +	struct ufshcd_crypto_ctx *cctx;
>> +#endif
>
>or here.
>
Ok, I will remove it.
>>  };
>>
>>  /* Returns true if clocks can be gated. Otherwise false */ diff --git
>> a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h index
>> 6fa889d..fe5a92d 100644
>> --- a/drivers/scsi/ufs/ufshci.h
>> +++ b/drivers/scsi/ufs/ufshci.h
>> @@ -90,6 +90,7 @@ enum {
>>  	MASK_64_ADDRESSING_SUPPORT		=3D 0x01000000,
>>  	MASK_OUT_OF_ORDER_DATA_DELIVERY_SUPPORT	=3D 0x02000000,
>>  	MASK_UIC_DME_TEST_MODE_SUPPORT		=3D 0x04000000,
>> +	MASK_CRYPTO_SUPPORT                     =3D 0x10000000,
>
>Why are you all not using the BIT(N) macro for these?
Yes, I will replace it with BIT(N).
>
>thanks,
>
>greg k-h

Regards,
Parshuram Thombare
