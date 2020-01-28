Return-Path: <SRS0=qLSf=3R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B415C2D0DB
	for <linux-block@archiver.kernel.org>; Tue, 28 Jan 2020 19:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6C924681
	for <linux-block@archiver.kernel.org>; Tue, 28 Jan 2020 19:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgA1T2M convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:28:12 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:15120 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbgA1T2M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jan 2020 14:28:12 -0500
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SJMpgL014432;
        Tue, 28 Jan 2020 19:28:04 GMT
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 2xtrm6sab9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 19:28:04 +0000
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2353.austin.hpe.com (Postfix) with ESMTPS id 20104A5;
        Tue, 28 Jan 2020 19:28:02 +0000 (UTC)
Received: from G4W9327.americas.hpqcorp.net (16.208.32.97) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 Jan 2020 19:27:52 +0000
Received: from G2W6311.americas.hpqcorp.net (16.197.64.53) by
 G4W9327.americas.hpqcorp.net (16.208.32.97) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 Jan 2020 19:27:52 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (15.241.52.10) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 28 Jan 2020 19:27:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jv/7gkpBNPTbnnrA4yEpOKi3euFaBKpez0Epc2155bG6Z5ZE2wM1buvaNYr53fg//4YJFkKP1P+ejGmNlrX+QK070Upi1OB6/ORpRXGRLPxAfGtjFhtfHCwJcI0HVU9GVi9/6QqYk3sWWMpChVBOwLGUwqrodmzjU74F3UTXil0ekVq3ABgRzz0lYLc1DU5tJfsYrKAjPRf8p+cJbsLvlcEnSV5YMLsl/WHkeS3T4GAKq2a3xhAMJI8vEDy52GZjwEANRXLnWEa1sUmODZrfUMT7N08q1CJ3sGC/H2yy36X7A6rp1jl9g1b1PiJIJ38klrY2nTCuVn9B9QxiVOkvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BASqoOINSZ6l9CEAFiun0vBL4kcd3tBhyDC2QaIkKaA=;
 b=a416L7o8oxOYDJ5MEDjquisTW2veyo74iHS1vTu9GyoC2fErj/tSHBDeIQ78oo5TEYz1l9jZoQPJ3BEvrmkO2RXf3QVyf8J6dNI7THuLe1KrCltf5EjRt63Lk5vgI7lzFvQm8ELUKQB/M3cpuE2f/5LfGF6alQoNbmj/AJFYuBKWV7+nFLEz4YrCZY8ozIjnlYPYaWfa+YnDj7WGPpyNtnh+P3IIvuJwaUt44lkiuHx+7qkfIzxMyDZbZq3hnzRuEyjPMCvWSy3xjR7VYAZEsBsfz+inkVs0G581JA2LPBDSQUpPEu6jqQexqes/Ub+bxUF+T8JzLo5gyrUd35zggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB1237.NAMPRD84.PROD.OUTLOOK.COM (10.169.97.143) by
 CS1PR8401MB0502.NAMPRD84.PROD.OUTLOOK.COM (10.169.14.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 19:27:50 +0000
Received: from CS1PR8401MB1237.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6913:a11a:3f11:fa4f]) by CS1PR8401MB1237.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6913:a11a:3f11:fa4f%3]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 19:27:50 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Omar Sandoval <osandov@fb.com>
Subject: RE: [PATCH blktests v1 2/2] nmve/018: Reword misleading error message
Thread-Topic: [PATCH blktests v1 2/2] nmve/018: Reword misleading error
 message
Thread-Index: AQHV1bc8suLzVScMOUmStC4vuY1U9qgAdWlg
Date:   Tue, 28 Jan 2020 19:27:50 +0000
Message-ID: <CS1PR8401MB1237A6FBBBA1436C93F89B78AB0A0@CS1PR8401MB1237.NAMPRD84.PROD.OUTLOOK.COM>
References: <20200128084434.128750-1-dwagner@suse.de>
 <20200128084434.128750-3-dwagner@suse.de>
In-Reply-To: <20200128084434.128750-3-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.211.195.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2efef4ed-99eb-410c-a839-08d7a4282a03
x-ms-traffictypediagnostic: CS1PR8401MB0502:
x-microsoft-antispam-prvs: <CS1PR8401MB05026D7DB8794727A211B37CAB0A0@CS1PR8401MB0502.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(39860400002)(366004)(376002)(199004)(189003)(4744005)(9686003)(186003)(4326008)(53546011)(6506007)(26005)(52536014)(54906003)(5660300002)(110136005)(81166006)(71200400001)(55016002)(81156014)(8676002)(8936002)(316002)(86362001)(7696005)(76116006)(66476007)(66946007)(15650500001)(66446008)(478600001)(64756008)(66556008)(33656002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CS1PR8401MB0502;H:CS1PR8401MB1237.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +H8kDqJe2Ey2r4QleONlGbdDBkUBiLzoqWtb/FBgRqWX8xgYWVt8NGaRYMbaNcpW9gjgjIavqsmBY+aIpOcTsI7qmzR+Qh8N8X09R7f7o5A/hdjrBWIy4Y4QlFsK6Q/3FM3B9h0dDHZg0WVfXU5UaB+3ofwEvXoh6HqrCbjGQ/SzO8B6AIE6CWvsBAJZzZu+bIAaOYRPeDnfWwxSfPyatiGUD9OqSCg7RebU0/4kxXNljT/kD6g+IlS8SScm5TqSQPm3hml/NHQZbKGqDip2YgIBEshK9aQ8vuoOmpLF445nz9+vRpBBIODv7ypseVLNN6vmEacd+PKSkuL7YW77o9yp52Ctux37xHNNNKJOfS73+z1tQuFNdcXW13kcrU1DdCJ8n/mL6ZAy8Fd4qaCtCg5aIPgJMAAU5EVRJpYgkyNA39JHbzrOObH53UWV/JvA
x-ms-exchange-antispam-messagedata: zPVHr6wq0yxJdm0dVRKglaNHY483t+NYHmJYp9DbyTWMvYDwr+t7yniyH93WzHWOvIrs018UYRODQkpoZbk76dDbcRp3i6K0Z5BTyJIQhlnIRwLPqh8FYBxmtbpAXyu53pIkbETUQPYyHGlxhFsMwA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efef4ed-99eb-410c-a839-08d7a4282a03
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 19:27:50.6054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBTDDUjD040pJVBZ3jqyOx2VfUr/EcQuyWgq0wgZyiU+g8Kpd4W083wChT5Z78Lz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0502
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_07:2020-01-28,2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001280145
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -----Original Message-----
> From: linux-block-owner@vger.kernel.org <linux-block-
> owner@vger.kernel.org> On Behalf Of Daniel Wagner
> Sent: Tuesday, January 28, 2020 2:45 AM
> Subject: [PATCH blktests v1 2/2] nmve/018: Reword misleading error message
> 
> 'nvme read' is expected to fail, though the error message "ERROR:
> Successfully..." is misleading. Reword the error text to clarify the
> real indent of the test and what failed.

intent

> 
> Reported-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
...
> -		&& echo "ERROR: Successfully read out of device lba range"
> +		&& echo "ERROR: nvme read was successful for out of range lba"
> 

To avoid being picked up by a grep for "success", you could use:
    ERROR: nvme read for out of range LBA was not rejected

