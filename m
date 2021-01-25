Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793BCC433DB
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 02:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4202C22AAA
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 02:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbhAYPd4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jan 2021 10:33:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729845AbhAYO4v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 09:56:51 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10PEW8uA190023;
        Mon, 25 Jan 2021 09:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc :
 references : subject : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ccaBuw3Lf3Q7m9bGxHCNfUXZ2tIMoQgu6UK8lZueDAY=;
 b=o3u9y6nCmEOcMpTQkYt1y9o8XSh0TmNfQIvBfxjSM/LcRcrun/yaUpUYnEArsG8ahVkf
 307f0pl3vNR8kTYB9v+YyG2sPlQABdBciO4zA2wjBFf61g3598pfruSeEKbcIHCupQPu
 NQzkX+g1ARsBH2TjB/mt8oq6OZ6g+myJ82JYpu81GcX4/WiXVKLZkxsmq0O9ntbOTSMr
 I2hOoIl0/cFfryVZLpc5+xE/hKfxnV5uI5fFyqOl4yf5UT0gLK3BXGtpGFIYksFUWtb8
 cxE1taVsPhpVyjakXMJX8+logmfsJ3EXFXJWV0cZquu7mhs0e1WymXjLFcdFghcIAgXg rw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 369x3x4fg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jan 2021 09:56:04 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10PEm31g015805;
        Mon, 25 Jan 2021 14:56:02 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 368b2h8yvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jan 2021 14:56:02 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10PEtxRm41419048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 14:55:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A38A3A4055;
        Mon, 25 Jan 2021 14:55:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B91FA4051;
        Mon, 25 Jan 2021 14:55:59 +0000 (GMT)
Received: from linux.fritz.box (unknown [9.145.26.175])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jan 2021 14:55:59 +0000 (GMT)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
References: <20210118165518.14578-1-sth@linux.ibm.com>
 <20210118165518.14578-2-sth@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/dasd: Fix inconsistent kobject removal
Message-ID: <7e7051ac-dbe2-2951-2362-1bc9e7a8dfc6@linux.ibm.com>
Date:   Mon, 25 Jan 2021 15:55:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210118165518.14578-2-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-25_04:2021-01-25,2021-01-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101250081
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

small question.
Do you plan to include the fix still for 5.11 or with the merge window
for 5.12?
The faulty patch was included in the 5.11 merge window.

Best regards,
Stefan

Am 18.01.21 um 17:55 schrieb Stefan Haberland:
> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>
> Our intention was to only remove path kobjects whenever a device is
> being set offline. However, one corner case was missing.
>
> If a device is disabled and enabled (using the IOCTLs BIODASDDISABLE an=
d
> BIODASDENABLE respectively), the enabling process will call
> dasd_eckd_reload_device() which itself calls dasd_eckd_read_conf() in
> order to update path information. During that update,
> dasd_eckd_clear_conf_data() clears all old data and also removes all
> kobjects. This will leave us with an inconsistent state of path kobject=
s
> and a subsequent path verification leads to a failing kobject creation.=

>
> Fix this by removing kobjects only in the context of offlining a device=

> as initially intended.
>
> Fixes: 19508b204740 ("s390/dasd: Display FC Endpoint Security informati=
on via sysfs")
> Reported-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_devmap.c | 20 ++++++++++++++------
>  drivers/s390/block/dasd_eckd.c   |  3 ++-
>  drivers/s390/block/dasd_int.h    |  2 +-
>  3 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd=
_devmap.c
> index 16bb135c20aa..03d27ee9cac6 100644
> --- a/drivers/s390/block/dasd_devmap.c
> +++ b/drivers/s390/block/dasd_devmap.c
> @@ -1874,18 +1874,26 @@ void dasd_path_create_kobjects(struct dasd_devi=
ce *device)
>  }
>  EXPORT_SYMBOL(dasd_path_create_kobjects);
> =20
> -/*
> - * As we keep kobjects for the lifetime of a device, this function mus=
t not be
> - * called anywhere but in the context of offlining a device.
> - */
> -void dasd_path_remove_kobj(struct dasd_device *device, int chp)
> +static void dasd_path_remove_kobj(struct dasd_device *device, int chp)=

>  {
>  	if (device->path[chp].in_sysfs) {
>  		kobject_put(&device->path[chp].kobj);
>  		device->path[chp].in_sysfs =3D false;
>  	}
>  }
> -EXPORT_SYMBOL(dasd_path_remove_kobj);
> +
> +/*
> + * As we keep kobjects for the lifetime of a device, this function mus=
t not be
> + * called anywhere but in the context of offlining a device.
> + */
> +void dasd_path_remove_kobjects(struct dasd_device *device)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < 8; i++)
> +		dasd_path_remove_kobj(device, i);
> +}
> +EXPORT_SYMBOL(dasd_path_remove_kobjects);
> =20
>  int dasd_add_sysfs_files(struct ccw_device *cdev)
>  {
> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_e=
ckd.c
> index 3caa1ee5f4b0..65eb87cbbb9b 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -1036,7 +1036,6 @@ static void dasd_eckd_clear_conf_data(struct dasd=
_device *device)
>  		device->path[i].ssid =3D 0;
>  		device->path[i].chpid =3D 0;
>  		dasd_path_notoper(device, i);
> -		dasd_path_remove_kobj(device, i);
>  	}
>  }
> =20
> @@ -2173,6 +2172,7 @@ dasd_eckd_check_characteristics(struct dasd_devic=
e *device)
>  	device->block =3D NULL;
>  out_err1:
>  	dasd_eckd_clear_conf_data(device);
> +	dasd_path_remove_kobjects(device);
>  	kfree(device->private);
>  	device->private =3D NULL;
>  	return rc;
> @@ -2191,6 +2191,7 @@ static void dasd_eckd_uncheck_device(struct dasd_=
device *device)
>  	private->vdsneq =3D NULL;
>  	private->gneq =3D NULL;
>  	dasd_eckd_clear_conf_data(device);
> +	dasd_path_remove_kobjects(device);
>  }
> =20
>  static struct dasd_ccw_req *
> diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_in=
t.h
> index 3bc008f9136c..b8a04c42d1d2 100644
> --- a/drivers/s390/block/dasd_int.h
> +++ b/drivers/s390/block/dasd_int.h
> @@ -858,7 +858,7 @@ int dasd_add_sysfs_files(struct ccw_device *);
>  void dasd_remove_sysfs_files(struct ccw_device *);
>  void dasd_path_create_kobj(struct dasd_device *, int);
>  void dasd_path_create_kobjects(struct dasd_device *);
> -void dasd_path_remove_kobj(struct dasd_device *, int);
> +void dasd_path_remove_kobjects(struct dasd_device *);
> =20
>  struct dasd_device *dasd_device_from_cdev(struct ccw_device *);
>  struct dasd_device *dasd_device_from_cdev_locked(struct ccw_device *);=



