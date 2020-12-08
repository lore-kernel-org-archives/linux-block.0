Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,BIGNUM_EMAILS,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EF5C4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 14:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA81E23A53
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 14:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgLHOIp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 09:08:45 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58316 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbgLHOIp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 09:08:45 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8E5Jwt043407;
        Tue, 8 Dec 2020 14:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=xnwmAWpUqmKI/eSZF7IX044mOOjJHJFpC0UxRySlD4E=;
 b=TdKU3OVm1SHY5t1XIybgOqnN7PdTX41po+lSWlGk6MvDtQlT29oryt9i8NbZXKrTV0is
 9s9q1KX50BeZjD/7av83ktMSlGMH+1ObfiAiXASSQyf3CeGudl+YoxdULyt1JG2uwjdU
 IlLXtk46OFq+syMGroWxPuU1S2I6hFllgV50ZRo8VPkHXKxKGP1+Ff929xqYim6ue907
 FcK2SlAdLGOrTnIMuS+lw3FQ9nM9zMrullC2/yjJ7H/hlNRrOb1Xctw0XZEPP2eapKgf
 B46iuEN/AKfJdEFdf8P5bzdbmOX3SCBVxRqh66p0Jf0YwS//rhwR9Y4jyYfFAbxLdedu qQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35825m2w57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Dec 2020 14:08:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8DutNO142260;
        Tue, 8 Dec 2020 14:06:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 358kyswut1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Dec 2020 14:06:01 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B8E60lI006488;
        Tue, 8 Dec 2020 14:06:00 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Dec 2020 06:05:59 -0800
Date:   Tue, 8 Dec 2020 17:05:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        linux-block <linux-block@vger.kernel.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Subject: Re: [bug report] block/rnbd-clt: Dynamically alloc buffer for
 pathname & blk_symlink_name
Message-ID: <20201208140552.GC2789@kadam>
References: <X89uUXoVbUFMg27k@mwanda>
 <CAJpMwyjwfPz-xt0VHuXzXuRROiHmy+9OFJSWsZV2ZcJS0MKS6g@mail.gmail.com>
 <CAMGffEm5PaFNR-4aSRFwNBRPFo-ukFGXXrs-8UFjhPJMC=YRsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEm5PaFNR-4aSRFwNBRPFo-ukFGXXrs-8UFjhPJMC=YRsw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080086
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 08, 2020 at 02:24:40PM +0100, Jinpu Wang wrote:
> Hi,
> 
> On Tue, Dec 8, 2020 at 2:21 PM Haris Iqbal <haris.iqbal@cloud.ionos.com> wrote:
> >
> > On Tue, Dec 8, 2020 at 5:45 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > Hello Md Haris Iqbal,
> > >
> > > This is a semi-automatic email about new static checker warnings.
> > >
> > > The patch 64e8a6ece1a5: "block/rnbd-clt: Dynamically alloc buffer for
> > > pathname & blk_symlink_name" from Nov 26, 2020, leads to the
> > > following Smatch complaint:
> > >
> > >     drivers/block/rnbd/rnbd-clt-sysfs.c:525 rnbd_clt_add_dev_symlink()
> > >     error: uninitialized symbol 'ret'.
> > >
> > >     drivers/block/rnbd/rnbd-clt-sysfs.c:524 rnbd_clt_add_dev_symlink()
> > >     error: we previously assumed 'dev->blk_symlink_name' could be null (see line 500)
> > >
> > > drivers/block/rnbd/rnbd-clt-sysfs.c
> > >    493  static int rnbd_clt_add_dev_symlink(struct rnbd_clt_dev *dev)
> > >    494  {
> > >    495          struct kobject *gd_kobj = &disk_to_dev(dev->gd)->kobj;
> > >    496          int ret, len;
> > >    497
> > >    498          len = strlen(dev->pathname) + strlen(dev->sess->sessname) + 2;
> > >    499          dev->blk_symlink_name = kzalloc(len, GFP_KERNEL);
> > >    500          if (!dev->blk_symlink_name) {
> > >    501                  rnbd_clt_err(dev, "Failed to allocate memory for blk_symlink_name\n");
> > >    502                  goto out_err;
> > >
> > > ret = -ENOMEM; here
> > >
> > >    503          }
> > >    504
> > >    505          ret = rnbd_clt_get_path_name(dev, dev->blk_symlink_name,
> > >    506                                        len);
> > >    507          if (ret) {
> > >    508                  rnbd_clt_err(dev, "Failed to get /sys/block symlink path, err: %d\n",
> > >    509                                ret);
> > >    510                  goto out_err;
> > >    511          }
> > >    512
> > >    513          ret = sysfs_create_link(rnbd_devs_kobj, gd_kobj,
> > >    514                                  dev->blk_symlink_name);
> > >    515          if (ret) {
> > >    516                  rnbd_clt_err(dev, "Creating /sys/block symlink failed, err: %d\n",
> > >    517                                ret);
> > >    518                  goto out_err;
> > >    519          }
> > >    520
> > >    521          return 0;
> > >    522
> > >    523  out_err:
> > >    524          dev->blk_symlink_name[0] = '\0';
> > >                 ^^^^^^^^^^^^^^^^^^^^^^^^
> > > This will oops if the kzalloc() fails.
> >
> > Thanks. Will send a patch soon.
> already fixed in block tree by Colin
> >https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.11/drivers&id=733c15bd3a944b8eeaacdddf061759b6a83dd3f4 

It's a weird thing that we don't free dev->blk_symlink_name if there
is an error.  It's impossible for rnbd_clt_get_path_name() to actually
return an error in the current code, but if it did then only the last
character of dev->blk_symlink_name[] is initialized.

regards,
dan carpenter

