Return-Path: <SRS0=7YUI=UX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734F2C4646C
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 22:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C79520674
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 22:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JGNj9qVb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fKHBfaJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfFXW16 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 18:27:58 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:57302 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfFXW16 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 18:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561415278; x=1592951278;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Ad2l5Rxs2ffri8g3/mqgPG6MkPo0WoV3ruZusr+gDMo=;
  b=JGNj9qVbmozRW8+dFxTTdY0KgyS+pg+7fOTmlE12yLUuXH8q8eG+sPCS
   5TA2tmxC8LKzc81vvT4LW0HKnBXLIKOLO4/dxlX4Gjom9f6aa1jBXL6Gv
   mY0WIUGQEVY63ywo0Yq/NI9/ZHWVWtdKWIrEuSlgjof6jTi2T701/GrXQ
   fi3nUAdQ8/LTmhbHRI9Qn+a0YgSXvKOeyxDCEn50HOuGeUVhjNHesZKxP
   udLM+6Wm5CoQZ7u8/0cK7xgyM8ECyJkx9wbBI7o1rVe4F4PFdnasEW5xN
   0J/25yExLiJQDLyFVsHbvLFEm0xBqIWyxjP9N1UpuaSSEjTsmE5rwYIES
   g==;
X-IronPort-AV: E=Sophos;i="5.63,413,1557158400"; 
   d="scan'208";a="113058832"
Received: from mail-co1nam04lp2057.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.57])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 06:27:57 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqNwmNu5y/f2dDCnQjmEaTDgAzDeVr7iRYr3FaankfI=;
 b=fKHBfaJYGdwkzrI+S7TORyjZlHR+bWnvzSxZp0rS+eUWKvhOmiTqCqJZed0JQKtRV9ZR4v9JkCeJkZJ+FTn0yUYgtpqGKGfsbI9dOZJNf/LINcpTfTBcRpmLhypGwW2dEJzM1Hys21rIsd/+OwlY6tIxuMYqbYGQ3ovHyqXBE0E=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5510.namprd04.prod.outlook.com (20.178.232.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Mon, 24 Jun 2019 22:27:55 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 22:27:55 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH 1/4] block: add zone open, close and finish support
Thread-Topic: [PATCH 1/4] block: add zone open, close and finish support
Thread-Index: AQHVKDJQD2Z4QYw9b06emkXLk9EL8A==
Date:   Mon, 24 Jun 2019 22:27:55 +0000
Message-ID: <BYAPR04MB5749CEFBB45EA34BD3345CD686E00@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190621130711.21986-1-mb@lightnvm.io>
 <20190621130711.21986-2-mb@lightnvm.io>
 <ee5764fb-473a-f118-eaac-95478d885f6f@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f19b20c5-2b5f-4ce0-1129-08d6f8f3345f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5510;
x-ms-traffictypediagnostic: BYAPR04MB5510:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5510DDA3901AD74B1FC1B8E386E00@BYAPR04MB5510.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:494;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(71190400001)(76116006)(4326008)(52536014)(25786009)(2501003)(71200400001)(5660300002)(33656002)(66574012)(66946007)(73956011)(66446008)(64756008)(66556008)(66476007)(68736007)(54906003)(486006)(316002)(476003)(110136005)(446003)(14444005)(256004)(6116002)(3846002)(7416002)(66066001)(76176011)(72206003)(102836004)(53546011)(6506007)(99286004)(186003)(26005)(55016002)(7696005)(53936002)(6246003)(478600001)(6436002)(86362001)(8676002)(2906002)(2201001)(9686003)(14454004)(8936002)(229853002)(81156014)(7736002)(81166006)(305945005)(74316002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5510;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 201BaMtI03Vi7dtOD1ZJgoB3JwjF8mf77v7Gzcs1YS9HKG04swsK21mWQQX17bOXylHKuFhh9nnwUAT2F8QbSY+LBVS83zqmP0vhPAK2Zyp008GtlmZmJDKe2rR7apm43B1mwfLanffZWjqJdvLlbQFiIQ965Jh+AxCXWYHbc+UAmLt0mRUlxfAw2UsEyCY6YS6fYysEfcRdSn7w4GLIzs7jf1uTa8l22/cndNhJM49u7jH6/qF/sO8H2B006xClgj/XWxXrKnVMFVAwdOvSQJWWKW2M3uulY+CphqnlYHoloo3gbPEG+tK7cPC5FAEWjQ/IrzvOrqOeMeJXXLehR2Pw7+IEFmzEeNtB527qjjk8Oq4alkRaaLarDYsv/qcr3HTNOiKWGQ7KEsoA/945ajuZe7ROf/52BKx6GGm8W8o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19b20c5-2b5f-4ce0-1129-08d6f8f3345f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 22:27:55.7511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5510
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/19 12:43 PM, Bart Van Assche wrote:=0A=
> On 6/21/19 6:07 AM, Matias Bj=F8rling wrote:=0A=
>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h=0A=
>> index 95202f80676c..067ef9242275 100644=0A=
>> --- a/include/linux/blk_types.h=0A=
>> +++ b/include/linux/blk_types.h=0A=
>> @@ -284,13 +284,20 @@ enum req_opf {=0A=
>>    	REQ_OP_DISCARD		=3D 3,=0A=
>>    	/* securely erase sectors */=0A=
>>    	REQ_OP_SECURE_ERASE	=3D 5,=0A=
>> -	/* reset a zone write pointer */=0A=
>> -	REQ_OP_ZONE_RESET	=3D 6,=0A=
>>    	/* write the same sector many times */=0A=
>>    	REQ_OP_WRITE_SAME	=3D 7,=0A=
>>    	/* write the zero filled sector many times */=0A=
>>    	REQ_OP_WRITE_ZEROES	=3D 9,=0A=
>>    =0A=
>> +	/* reset a zone write pointer */=0A=
>> +	REQ_OP_ZONE_RESET	=3D 16,=0A=
>> +	/* Open zone(s) */=0A=
>> +	REQ_OP_ZONE_OPEN	=3D 17,=0A=
>> +	/* Close zone(s) */=0A=
>> +	REQ_OP_ZONE_CLOSE	=3D 18,=0A=
>> +	/* Finish zone(s) */=0A=
>> +	REQ_OP_ZONE_FINISH	=3D 19,=0A=
>> +=0A=
>>    	/* SCSI passthrough using struct scsi_request */=0A=
>>    	REQ_OP_SCSI_IN		=3D 32,=0A=
>>    	REQ_OP_SCSI_OUT		=3D 33,=0A=
>> @@ -375,6 +382,22 @@ static inline void bio_set_op_attrs(struct bio *bio=
, unsigned op,=0A=
>>    	bio->bi_opf =3D op | op_flags;=0A=
>>    }=0A=
> =0A=
> Are the new operation types ever passed to op_is_write()? The definition=
=0A=
> of that function is as follows:=0A=
> =0A=
May be we should change numbering since blktrace also relies on the =0A=
having on_is_write() without looking at the rq_ops().=0A=
=0A=
197  * Data direction bit lookup=0A=
  198  */=0A=
  199 static const u32 ddir_act[2] =3D { BLK_TC_ACT(BLK_TC_READ),=0A=
  200                                  BLK_TC_ACT(BLK_TC_WRITE) };  <----=
=0A=
  201=0A=
  202 #define BLK_TC_RAHEAD           BLK_TC_AHEAD=0A=
  203 #define BLK_TC_PREFLUSH         BLK_TC_FLUSH=0A=
  204=0A=
  205 /* The ilog2() calls fall out because they're constant */=0A=
  206 #define MASK_TC_BIT(rw, __name) ((rw & REQ_ ## __name) << \=0A=
  207           (ilog2(BLK_TC_ ## __name) + BLK_TC_SHIFT - __REQ_ ## =0A=
__name))=0A=
  208=0A=
  209 /*=0A=
  210  * The worker for the various blk_add_trace*() types. Fills out a=0A=
  211  * blk_io_trace structure and places it in a per-cpu subbuffer.=0A=
  212  */=0A=
  213 static void __blk_add_trace(struct blk_trace *bt, sector_t sector, =
=0A=
int bytes,=0A=
  214                      int op, int op_flags, u32 what, int error, =0A=
int pdu_len,=0A=
  215                      void *pdu_data, union kernfs_node_id *cgid)=0A=
  216 {=0A=
  217         struct task_struct *tsk =3D current;=0A=
  218         struct ring_buffer_event *event =3D NULL;=0A=
  219         struct ring_buffer *buffer =3D NULL;=0A=
  220         struct blk_io_trace *t;=0A=
  221         unsigned long flags =3D 0;=0A=
  222         unsigned long *sequence;=0A=
  223         pid_t pid;=0A=
  224         int cpu, pc =3D 0;=0A=
  225         bool blk_tracer =3D blk_tracer_enabled;=0A=
  226         ssize_t cgid_len =3D cgid ? sizeof(*cgid) : 0;=0A=
  227=0A=
  228         if (unlikely(bt->trace_state !=3D Blktrace_running && =0A=
!blk_tracer))=0A=
  229                 return;=0A=
  230=0A=
  231         what |=3D ddir_act[op_is_write(op) ? WRITE : READ];  <--- =0A=
=0A=
=0A=
> static inline bool op_is_write(unsigned int op)=0A=
> {=0A=
> 	return (op & 1);=0A=
> }=0A=
> =0A=
=0A=
