Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923C4C433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 16:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbiDFQbL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbiDFQam (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 12:30:42 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147832F86DD
        for <linux-block@vger.kernel.org>; Tue,  5 Apr 2022 18:44:37 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 235IjIqd022777;
        Wed, 6 Apr 2022 01:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=hDay7Ufbh3P/zRaDh22Gqu5qyqqMHDh3PjjNg0WilrA=;
 b=G7T87V2w/rIpKj/S31HNuAesI/80zx36SAgolPACOnrY8ubiJCOiYKhiOmfi4kAxgv+I
 xWXdDdDC0t5UIStoBt6RSMHKJrvdNdIZaEj0Rqw/XRjEA5udAbKlyW/Uw6NC1VXwG18N
 jkxOSmEzVyi+GmmVcs6g7+4r4bFki2fd5ISGs/voo5n40s8IBzUmVqNXlUiEVGXlcH5p
 nXe5utpHabju8Jbsv+HReb2z3DpgD2UZuBcaJPw26dFPppdcQXzaNbMuUVZ4W8K5I7Qm
 vdTHWRmnahdikX1PpkYPdbHcKgQ8leHMYyLQNxA8C5FdVuLV95AIvKJ3QAouhDW3ilLZ wg== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3f8uat2e79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 01:44:10 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 557E8805E63;
        Wed,  6 Apr 2022 01:44:09 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 5 Apr 2022 13:43:58 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 5 Apr 2022 13:43:58 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 5 Apr 2022 13:43:58 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 5 Apr 2022 13:43:57 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpjNzV2EGYENHyIMi/451URJ1Y4rb3KPHZ4+QnKbSCDO41CHYkaj28T1EH+DCp810Drtvgi/6QKfGVHFl5E0nH+KdxOlHrfvhvJcW5z3GyTIy6UIqwFCuIt417qW7NIYbs0Kp7iyv34rgz3MPFUNC4CzOUm9fggaDlfnF8+neZicq62axMK9Rn4aL9wnnrAEzQ8DuVPCxYbyBdzJS78UAwHBxRaqVt/n5ENu4lsGglKK12ZuaJMmU7IlEgwQpaP3UCxCbKciFgK0/mvJqvY3b13apBa6/5bGNX0ZlICgC/w9G+DAZDKNXUmZRq1eMKjpOHfAx3VRgaY49TxxV5LTJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDay7Ufbh3P/zRaDh22Gqu5qyqqMHDh3PjjNg0WilrA=;
 b=I6/DZnV6Xo3aDcDwJHuf7d1OVdnADdhZpqCVLA6H7SdHIJMDDxO2dysZDEl0KzmX7CI9DR1JQMt3ktzsskQWuxZJ882n5myutnPbwW9fH9P5eRRCvFcjgnhMRq+EgwzaUPZc2vGNvzj9tkmFnKYMtiQadLF8ZpY/TscSA4q9K4lYl/vuWlGwaBvsKMN1efoPo2TeIamEbmQlJEAlBwKPBkGhmYq3jxAYD6KtXXX35/IJVYcE6I1Xlg3AdIXvlD7AIT6RpFQ4ZLYnnG54U5fftrghB06kBteqE90WIcX/s+Buj7n87XCafOGkQhmzhlIfvWFw9T7pY8dQHTusrYT6pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by DM4PR84MB1781.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Wed, 6 Apr 2022 01:43:56 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::207f:1aba:a6e4:970d]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::207f:1aba:a6e4:970d%9]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 01:43:56 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     'Suwan Kim' <suwan.kim027@gmail.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "mgurtovoy@nvidia.com" <mgurtovoy@nvidia.com>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: [PATCH v5 1/2] virtio-blk: support polling I/O
Thread-Topic: [PATCH v5 1/2] virtio-blk: support polling I/O
Thread-Index: AQHYSSdMWk/BWB3cek+K6rYGyQE6+6ziGr5g
Date:   Wed, 6 Apr 2022 01:43:55 +0000
Message-ID: <MW5PR84MB18421588C1806B6E37FCECAEABE79@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220405150924.147021-1-suwan.kim027@gmail.com>
 <20220405150924.147021-2-suwan.kim027@gmail.com>
In-Reply-To: <20220405150924.147021-2-suwan.kim027@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb4b4fe9-be10-4250-ef65-08da176ee9ae
x-ms-traffictypediagnostic: DM4PR84MB1781:EE_
x-microsoft-antispam-prvs: <DM4PR84MB1781E48806726C9E3B871DEFABE79@DM4PR84MB1781.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ro7ZSBQ2SznBsnEGVNW9HxJaXqZy8l07Bptzf6QWXOdgDEvzK1o5hIFU0DgjksFiA0rliEnRHplnrrl6Btvfg5XHqExA4IjNBNSLB8prPgHkS6pX1QcPSADEYQzvRyhT3qg9nlyyRHxQQyS4T63RKWsuHGMDwUoUwtKoT+RAf5QDQXpTSf0Nk9/o4sIfzka9EBxWTN0A3r9ca5HF+Z70Do9ExoJSySNYA4dM6OzItaL8nljUcVEm6Z2pasQLWhA1UUi9DFo9oaXuT8clwvH9N8qve3CmBDbtdzFOlxPcTtfHWcDF/UGXeryqKVvTKANkffrclS2pwksYwPDISTg5XVys6Zve2RIZkUmnqgT16hDDpGROgCPmz8TfRb9GhugzP1VyKEIEXGlGMk3xOpW57yrl3nZerp9blnq+THWpk/nvhVfwgubqYd+bK7ZYM7LuohEwHnzwO6KR+uKaVSXCKBbZkEuRtUKJF7GvBmdJtF5cqlLh5F1hRfkMU/Ik6Sbb5pZE/pwpT5lVa0VNTQRYDkAgNvHeeWn+/HdsXGspzyzT5s7xf6znQzVHKS/Umayt4xYHMYzbUdMa704je+VTFTYaLyMX8kxaeiI5bg3F8a8DtSAUBUJogHFFVPyUaRZUHcsuD8gxa7zT0rI/uTP/j+CcdwrF0ytR5j7gaGVTfgVTgNfW0mZ7iyQiC6dgkMgOlBtGj8sfwgL9nELoS/epYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(54906003)(7416002)(5660300002)(83380400001)(52536014)(26005)(86362001)(38070700005)(186003)(8936002)(508600001)(4744005)(38100700002)(55236004)(110136005)(2906002)(66446008)(76116006)(9686003)(66946007)(316002)(122000001)(6506007)(7696005)(66556008)(66476007)(55016003)(71200400001)(8676002)(82960400001)(53546011)(4326008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SiH7Tqz5HRAC7Tv6r75xW02dms1O1vBohCVhs4oytyqt+GCMM3IxqaT6raCc?=
 =?us-ascii?Q?oS+lRh5wnX7Yewi2dAFwPuSfc0vdOESKE5b3osu7ED93Kx4EIqOohZ7gZW2H?=
 =?us-ascii?Q?+shrdqEsN9ixBrY2jD7pjviDd7HUjIzA15q8f2imewQ/u3+fM+Vh+lY3v6cw?=
 =?us-ascii?Q?56/IuxxA3VPv7Mr21abF238IZKrCxKoKV0V9Ir+8HqRbWn5p5UciI5YuNAWh?=
 =?us-ascii?Q?PJgRnhunbod+lHgtTJ/2I/FRCh5587cQmPnwFJ52jOJ7sFPg1AxeQKj+FapR?=
 =?us-ascii?Q?v95YQcwzsxN1+YSmlgSlRD9tiuXBOgKKQaYELYoiawB23KERvsvd1kpS7xtt?=
 =?us-ascii?Q?dZOJfqqMG0yEiETsiY7J6FrzIKtXqT8YxPWL82PaEPXiSqn9yoK7wCeIlm8Y?=
 =?us-ascii?Q?VtUzo2Xpj/p1CNWzS/QhF0qvX8N+sq2xLu0qR+L078xL8drksJEbhVpYlyuE?=
 =?us-ascii?Q?nYzT+ynlG3Vo/JPAEB7V507TMLw8X7aeix5e1wl0pMPaFXGgFsgHsR7dAGdl?=
 =?us-ascii?Q?eqEeMctH8A2vw9sVYLWi5GcZbfJL+swESu8l4QYr7J1ESD+bfApEHXpPn2Hr?=
 =?us-ascii?Q?2E6IaFWF17jF1sGgPHhJKAiwieuyMvGllQDbbWKbDTuH1ohFIY/VKqg4FZj6?=
 =?us-ascii?Q?d4DXf/CqFy5OodRReWxXr92OoeuupRbD7Hq74fxNx5UlvX8URNAX6/kQhWwt?=
 =?us-ascii?Q?p+/fJggUzXy3ZqQFVyptpCxGtuy/4odZ/p/aaPfMLNEn9YvkonJyiy19a5Q5?=
 =?us-ascii?Q?x1HcWKmu8yI51TgsDRJSjOoK15aTeGexxTabi5PWCcSkTX0QQvyTYxBdKXH+?=
 =?us-ascii?Q?iaUn9J8UqsZXmO8vEkYSZyDjIVt/9BihzYWLEvKq0HT25rkQ+wDmDaYP4ZGB?=
 =?us-ascii?Q?EdnCoHSjVFyV9WGZ8o/ayzEBjFi2FuvLO/BRB+Lt9uOHaRCAXK6oiewDoy4K?=
 =?us-ascii?Q?KfX6ft1GeGaMb35yFtJsawgDj+uVQArJJGbnowcLEWjbPm2T9SQW9WJIqjfr?=
 =?us-ascii?Q?v11kYWtR1Qmw/jxZWMTij8Nr6h4wn8RtjzK0MmZ2KpqKfvGOHzwHWHatXBlv?=
 =?us-ascii?Q?o++Od6q8LBnLW78fOjhWXSAENKLe7aAqcKIeet3pVwX+Zvsl922hFpX6/1+a?=
 =?us-ascii?Q?XlFB2iMaTrtJEGHlapLfIz/0YvBG29Jmv2oyyGarAOEsxjKUlQSeiq3rnGQb?=
 =?us-ascii?Q?++CdpUS1d8AlqMovDi0WEbfWoGPesfiH1iabgSft4/aoxnxDkuDNWHcp9CUa?=
 =?us-ascii?Q?nQPhbUJ56ZDdSTT98zP0UkkT1qx2r2Vlm/huZM0y7hNC3gLZ8SIng7Df+gnl?=
 =?us-ascii?Q?34/peHivGGG5Yus4PhBHYUpL38bop9RkgmTNm87ruOTqAX2BDq6CAop5RAEu?=
 =?us-ascii?Q?KASZgDOn8jWJxpj9nHEjowO4Murgn9vY6+znti4QmmnQh6fiV2qI68G8o80c?=
 =?us-ascii?Q?EmYja6fPBZg7GgbvTh0YcOxpVG7AdmzUttBoAAJ5HoyUkzUaNO+eAabTywQf?=
 =?us-ascii?Q?YfEWbUG8oH2eRLiRB9W419Lh7QcyffNNQNtauCCKbkkw7GaTDnHIgxegge9I?=
 =?us-ascii?Q?lRvG9LJNTHiJw1MTZ75DxJac7OraEtDFNrJY9a3lCjwqDJZpJL9HCW/MAQe3?=
 =?us-ascii?Q?joG1sEUtTpQB/zTQVoh1O7unlu4n5Nm5/UK1urSPd7tkgI10I2IShXWNgaZZ?=
 =?us-ascii?Q?xB0kF5jMOmnFa+/2r6to6CLgR4GP7T2bV1UMlwhew8+6QG8Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4b4fe9-be10-4250-ef65-08da176ee9ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 01:43:55.8869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5erg7QBVz9Pyy90LF2GZt5IXv6UqzfvW8TXA2MuCtEenEw4w2cOiFJNIKVdMhYj4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1781
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: K7gpsa2LQAKvyTupRuRM9qV8PBsEUYQX
X-Proofpoint-GUID: K7gpsa2LQAKvyTupRuRM9qV8PBsEUYQX
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-05_08,2022-04-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 mlxlogscore=794 suspectscore=0
 phishscore=0 impostorscore=0 clxscore=1011 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060003
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> -----Original Message-----
> From: Suwan Kim <suwan.kim027@gmail.com>
> Sent: Tuesday, April 5, 2022 10:09 AM
> Subject: [PATCH v5 1/2] virtio-blk: support polling I/O
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> @@ -81,6 +85,7 @@ struct virtio_blk {
>=20
> 	/* num of vqs */
> 	int num_vqs;
> +	int io_queues[HCTX_MAX_TYPES];
>  	struct virtio_blk_vq *vqs;
...
>  };> @@ -565,6 +572,18 @@ static int init_vq(struct virtio_blk *vblk)
>  			min_not_zero(num_request_queues, nr_cpu_ids),
>  			num_vqs);
>=20
> +	num_poll_vqs =3D min_t(unsigned int, poll_queues, num_vqs - 1);
> +
> +	memset(vblk->io_queues, 0, sizeof(int) * HCTX_MAX_TYPES);

Using
    sizeof(vblk->io_queues)
would automatically follow any changes in the definition of that field,
similar to the line below:

...
>  	vblk->vqs =3D kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);


