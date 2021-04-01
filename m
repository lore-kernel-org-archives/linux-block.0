Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733A5C43460
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 18:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CDB06108B
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 18:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbhDASpu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:45:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47274 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239623AbhDASks (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Apr 2021 14:40:48 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131GOh7O136706;
        Thu, 1 Apr 2021 16:27:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=aGtGiGdno4YHAOwmoWjaN7bNguJAWV1E/lXgzVafuYo=;
 b=B3onf6uoRxD40vvKeoQANy2lN8u/MW2xtulJwbm+yuYXASG3dNEe/sFMWF7SzBSj6JUv
 F8dJosBbtJjamxC5LD2OyEzcsPoYR42mRWwkizghjmWJ7fSNAiSTcqtoe+3Bpz8Aeh3o
 KfFEPp5BeHPyaOjQZLtp5YTFGolesSQFCn/pXge2MvBbaVvdXskeC33cHA/i0B61g1Xi
 2TqdE4JedTxynyH+WHGC2GSQbO4H/QseOCUJS/pW9EbiiTg3CRPWpZG3QEmAOwzRy6qF
 hwa4ANUH/8Msd2NfkOjjK0qwsfVz6o6Slsuc3V1LRa2rrdrovYDAkL7YfCEmPFFedIjs Gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37n33dtcuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 16:27:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131GP47K138813;
        Thu, 1 Apr 2021 16:27:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3020.oracle.com with ESMTP id 37n2abf59r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 16:27:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnSeCKd1DNbuLB3A8Fz1tMZPQo5smmZMeiltlsOE9f6ubukXAYGm4dH+MC4pCWXpKSFSdUjiOKcC/DNi9x7jiPxaad02OM3o2b7Io2q/5HFpUmlLLC6QQ3ulP1N234U9Ea2BVpmGgq+wh+XxKF3492QYRzBLhyK0G3/E1R2tMGmhCvDTv8t+iGmzgTlh3RdBNs+acAjOJTpKaH9Qernp1D44yD3Mc4aVdsRyHCXE8JHOkZDoJjh4Wm7P6x3+hB7cru+Hr4N6yRp2sBwmgwuDvt2YexOWz0NthkgfMd0KTi8CTSq3iKxIKT4u15ffPvZyFN472a4z3wiXFV450QTD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGtGiGdno4YHAOwmoWjaN7bNguJAWV1E/lXgzVafuYo=;
 b=J4OputJQxov5O2FobdylR5EzWnOiIWnXCQAZERu0tPH3fwQTAeVNN8/wpHtieXa7yCt7hIHXU+7Imw/e+qp30qMFeYzRQU+jjOdb8BfLDs3f7BkClIBN4jKEov60rLpxSYxFClhEuy6vSW2t0XHedPYQgRgghPkKnYdld1smSlbGgut0Qx0BKG1ZGL6YplxAssgBtKD9aZTD/p+QDt3wGKolUTYml0IBfe3BT+hvucbSZX0ZroQwWTc6WhR5C7a1p6OWndTwemS+nCm6wisW1ddkQSupxTds5X32SOlJlXGgIcHLhuy9RY20OxPWxVzuBZET8Ww6Y3/fqI/x0VIfzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGtGiGdno4YHAOwmoWjaN7bNguJAWV1E/lXgzVafuYo=;
 b=jHQcY7oq7EfvzuWBo279uTHA3EhSGzar45UkUUagc5zurfJpfx6zhB4lCkZSSkfrIh2e5zzGtlYnehpDWABFeG3xLmY7qBAV2PY96hCS+IWd8/1Ber+Uyq6XsypBFkGV1Yg0yJLW/igU/LDFl842rfdajIh+LdYt7uufXS3O6yg=
Received: from CO1PR10MB4563.namprd10.prod.outlook.com (2603:10b6:303:92::6)
 by MWHPR1001MB2125.namprd10.prod.outlook.com (2603:10b6:301:2b::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 16:27:37 +0000
Received: from CO1PR10MB4563.namprd10.prod.outlook.com
 ([fe80::c15c:67c1:d5bd:eeb3]) by CO1PR10MB4563.namprd10.prod.outlook.com
 ([fe80::c15c:67c1:d5bd:eeb3%3]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:27:37 +0000
From:   Gulam Mohamed <gulam.mohamed@oracle.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: RE: Race condition in Kernel
Thread-Topic: Race condition in Kernel
Thread-Index: Adcgp2qLb8M/LezAQRGiUPxNQ9d23QAcTiOAAX6XFUA=
Date:   Thu, 1 Apr 2021 16:27:37 +0000
Message-ID: <CO1PR10MB4563673A20326DF5170CF60F987B9@CO1PR10MB4563.namprd10.prod.outlook.com>
References: <CO1PR10MB4563A6404AD789EEF93F995798639@CO1PR10MB4563.namprd10.prod.outlook.com>
 <YFvrZUzmdLpj7E4F@T590>
In-Reply-To: <YFvrZUzmdLpj7E4F@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [49.204.180.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a200f42-db8e-439a-6f02-08d8f52b1013
x-ms-traffictypediagnostic: MWHPR1001MB2125:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1001MB21252A2D1DEAFF65B7119E39987B9@MWHPR1001MB2125.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AaUVjLYqqaqtZXcQ/xPRZshv9BVRyftgm6lQiwhtMNg6KGk4g4uWMF+B5bs9XayVvtTVZD0usenbdDtOqC0LAzlpZwGmdiv2T/HaC9T2iIRt7Ma6y20tnxztfT8vtBsUwoWrodRu+ZFKq0TrNtBb2kf9BSLgryyMzqJyhfyRK/m+0CUYzIYvr2KxZMyu37yAKD1naei4CcVgsSbkNKlWDUqFaEQDvxFn+vyUzGSfsEBAGL6h2vs+UA8gD4tPqu4/wiJPGqVA7rcisJBlOwaKlhv2aawXUeeuT4JRV010Oypk2N19EZ0TMBdejTN7Cw5MRGiEeFVxBnZEekjiZcCKNrZtBVryyYhkql+P1wqnV4REhJiThGaXZLfKqdhH/5hdXW79/eTnnzRQxBq4cv0YOu7pd0Ucu5mBWhgEEDo7iVapg27Z8JMklDn9N5m07SFL7sWUuVwitlruN+Nu7+CaOILW9eyCSHBSOus0cfrC9x7zHtao5MzYn9DncDqoBalkCDaT5ISF6kS6ST5u1YkzpoWpoPHOgIuj/PQRG1zSIyrCMj757GXjYMqRDUyiGGJSXDPN+ORjqTSA3y6IHvirKgrw3HeHsQKdeRuJbDIrvFeJJ6WsqNx85FY4cEtj+PyhTeV8VGpEmFwAcf2It0an0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(396003)(136003)(376002)(86362001)(3480700007)(44832011)(316002)(83380400001)(2906002)(54906003)(9686003)(55016002)(66446008)(52536014)(38100700001)(33656002)(66476007)(66556008)(64756008)(26005)(66946007)(478600001)(8676002)(6916009)(8936002)(4326008)(7696005)(76116006)(186003)(53546011)(5660300002)(71200400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QbJ/wbX3/cp/PsWUPmLVRIJTc6rvfibjp8Uk51JMDbQ0//NLXUWQmck87PJA?=
 =?us-ascii?Q?YBLRz1HY3zHR+s2rj6GZV78gDZ8XS6ka03oIpbVe8/Am1KKBbNPrtlNV1O2v?=
 =?us-ascii?Q?CzaF6bLlV6TB9EnylWFJ0KgK70M07DkX0NZBjSIGm5JS3JIMmrbx8xatDQae?=
 =?us-ascii?Q?l1ZA9hHitfp/EuWtlmKtbfixTHXS5wMHW7A18qxk7A/tqxeZZsioVTBRmhKo?=
 =?us-ascii?Q?AoZhBU2/KN+PK63fwp7Z3oJ0YQg3wgELxggnzJTQTmbd20EtQ/AX+WkhlxMz?=
 =?us-ascii?Q?PIAPlCY8RxSyaliLIhilU5iCv3h72oveudN/fiFNk9NVQ39viiCt4iu7wuYu?=
 =?us-ascii?Q?K/m1LyvcBZFBIeaAoVJE7W8Aa9xXFGPeoo5v9oS0n2EjrtsvOjhRGQbQbwPM?=
 =?us-ascii?Q?vcdkBknlVwedG/SLCaO97xYRqz/6cPgb5V7sHSGwDiJk+nknChsq8/+zWbGG?=
 =?us-ascii?Q?d9dgSaZ0wLXHb2HTiLOPbNbIGE+kEfSba6wjFdWY2VAQcJ6yP1rcdV5Iq7Hn?=
 =?us-ascii?Q?sqx0M6tYZp2KJQXOkfO7YQDbafeaaVjJUoauZ+0hYywx+YoguojksVUskc0t?=
 =?us-ascii?Q?tSGmZE+wk5tuIxz2d+beHG9x+7DMX6Shnj1kYdvrz50yx6OO5vZxKk8ag0+7?=
 =?us-ascii?Q?VFQVGRY0G8vBMQV10jK8+BPZvYN73k84RgVs5Z6xVWo2duYEV+iY+w1GKPkk?=
 =?us-ascii?Q?3pb4/2Au2rEJ1Ddk/4Vs6beHOypGPxo9fffKFem3HjONYUHErCJMnW24FaTF?=
 =?us-ascii?Q?g1j1v1cNxKB3WplaATnCYCQe5wFycZ+7fDuVao9JI8WA9pyqstcV1a7k/tCE?=
 =?us-ascii?Q?xiAJVELK/Jy/o8ckuMZQ+6+Zygd3B08YeFm0MmUxakrOmqr1lBQdgGEE43Pv?=
 =?us-ascii?Q?Kkj8g8SpcMih+QYSIBGMEDa8ZYotRcVLOdhtf2h/R5ltJU76dYkdDrmyg8/N?=
 =?us-ascii?Q?nr4FOMYJ74QliDinQ46XVrcWDlj6E2ehisqsvUpJNe0UR8UZIlyDNax/DZ1Y?=
 =?us-ascii?Q?3/9coJig9bpkxQfR+v699rwGh667i1gSRK1Wyfvk1owRv0j08jeYOLCX0UAu?=
 =?us-ascii?Q?o65jgwCC9/tqhiUgXluJOtt6Pxe3CNAXvU5xBadlzYPStdO8MtGkKr9htQhT?=
 =?us-ascii?Q?ro2PxCKDmQwxdNxc7bhhakwvjQ2WLZNvkZhQcSJN8eEyqym6tDkv1bS8egCI?=
 =?us-ascii?Q?iuGECUJOra9SwGojT57fsiPXxe9Bvg2hReY5WSWUcyYG/fCvCrl/hvBWxi9F?=
 =?us-ascii?Q?IeKQTkoilUOmsPxLZ+gdnbNocVnwXfxLByIO9BmmAI9lsLnCpKw6WEROKF1i?=
 =?us-ascii?Q?XQA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a200f42-db8e-439a-6f02-08d8f52b1013
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 16:27:37.4326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6vaI8kAVLo/6sfR50KoZpglwH6DrqearaT8dE8skIJo5zwZDzGXHdWcb+CawHDCsPr8B6++Exb7h6FEq2nl7DrZlCHS3FjQcX1Tc3nvo8uQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2125
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010107
X-Proofpoint-GUID: AtqUYuruzaL2Est0Oy1-5AjXJw7mAlsW
X-Proofpoint-ORIG-GUID: AtqUYuruzaL2Est0Oy1-5AjXJw7mAlsW
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010107
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

      Thanks for taking a look into this. Can you please see my inline comm=
ents in below mail?

Regards,
Gulam Mohamed.

-----Original Message-----
From: Ming Lei <ming.lei@redhat.com>=20
Sent: Thursday, March 25, 2021 7:16 AM
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: hch@infradead.org; linux-kernel@vger.kernel.org; linux-block@vger.kerne=
l.org; Junxiao Bi <junxiao.bi@oracle.com>; Martin Petersen <martin.petersen=
@oracle.com>; axboe@kernel.dk
Subject: Re: Race condition in Kernel

On Wed, Mar 24, 2021 at 12:37:03PM +0000, Gulam Mohamed wrote:
> Hi All,
>=20
> We are facing a stale link (of the device) issue during the iscsi-logout =
process if we use parted command just before the iscsi logout. Here are the=
 details:
> 	 	=20
> As part of iscsi logout, the partitions and the disk will be removed. The=
 parted command, used to list the partitions, will open the disk in RW mode=
 which results in systemd-udevd re-reading the partitions. This will trigge=
r the rescan partitions which will also delete and re-add the partitions. S=
o, both iscsi logout processing and the parted (through systemd-udevd) will=
 be involved in add/delete of partitions. In our case, the following sequen=
ce of operations happened (the iscsi device is /dev/sdb with partition sdb1=
):
> =09
> 	1. sdb1 was removed by PARTED
> 	2. kworker, as part of iscsi logout, couldn't remove sdb1 as it was alre=
ady removed by PARTED
> 	3. sdb1 was added by parted

After kworker is started for logout, I guess all IOs are supposed to be fai=
led at that time, so just wondering why 'sdb1' is still added by parted(sys=
temd-udev)?=20
ioctl(BLKRRPART) needs to read partition table for adding back partitions, =
if IOs are failed by iscsi logout, I guess the issue can be avoided too?

[GULAM]: Yes, the ioctl(BLKRRPART) reads the partition table for adding bac=
k the partitions. I kept a printk in the code just after the partition tabl=
e is read. Noticed that the partition table was read before the iscsi-logou=
t kworker started the logout processing.
                   Following are the logs for your reference:

 Apr  1 09:23:27 gms-iscsi-initiator-2 kernel: ORA:: Calling sysfs_delete_l=
ink() for dev: sdb3 command: systemd-udevd		<=3D=3D sdb3 Removed by PARTED=
=20
Apr  1 09:23:27 gms-iscsi-initiator-2 kernel: ORA:: rescan_partitions() Rea=
d Complete to the disk: sdb command: systemd-udevd   <=3D=3D Reading sdb co=
mpleted, before iscsi-logout worker started
Apr  1 09:23:27 gms-iscsi-initiator-2 kernel: ORA:: Calling sysfs_delete_li=
nk() for dev: 3:0:0:0 command: kworker/u16:3
Apr  1 09:23:27 gms-iscsi-initiator-2 kernel: sdb: sdb1 sdb2 sdb3
Apr  1 09:23:27 gms-iscsi-initiator-2 kernel: ORA:: device: 'sdb3': device_=
add command: systemd-udevd		<=3D=3D sdb3 Added by PARTED=20
Apr  1 09:23:27 gms-iscsi-initiator-2 kernel: ORA:: Calling sysfs_delete_li=
nk() for dev: 8:16 command: kworker/u16:3
Apr  1 09:23:27 gms-iscsi-initiator-2 kernel: ORA:: Calling sysfs_delete_li=
nk() for dev: sdb command: kworker/u16:3	<=3D=3D sdb Removed by iscsi=20
Apr  1 09:23:27 gms-iscsi-initiator-2 kernel: scsi 3:0:0:0: alua: Detached

--
Ming

