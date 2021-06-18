Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAFDC48BE8
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 22:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8EAE60FE7
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 22:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhFRWFL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 18:05:11 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12]:38205 "EHLO
        mailout2.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbhFRWFK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 18:05:10 -0400
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20210618220259usoutp028249170ee5f96dd37ba4cb2c8e1b2fa3~JzE7c0JbQ1207612076usoutp02E;
        Fri, 18 Jun 2021 22:02:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20210618220259usoutp028249170ee5f96dd37ba4cb2c8e1b2fa3~JzE7c0JbQ1207612076usoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624053779;
        bh=NX9hF0lcdcXA9YUqrrf5edNsZ+iGF9ZxVPnGvL9HPBo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=C9IjFuoF3+f5jwIfjTBXrPk+y2Ye5q6DnS/ySoZpmkrLrH/hledFE82qPzIr/vEww
         2u2TPQgOV0kPuMJ+cMIGUbLOtNeMvbrmty2N7ppwfC9CCfbdvSWIMMMT2UPau4twqE
         NpW4uKkKaeA3nB7bh/SM5/o/oG7oiHwFh7ZA9IDQ=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210618220259uscas1p2c5b2c339f318546ea6f715fa78c6239f~JzE7A4t2H1697416974uscas1p24;
        Fri, 18 Jun 2021 22:02:59 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 96.A1.19318.3181DC06; Fri,
        18 Jun 2021 18:02:59 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210618220258uscas1p26dd26e2908d8466831cf8089a181ded7~JzE6oDgHW1703117031uscas1p27;
        Fri, 18 Jun 2021 22:02:58 +0000 (GMT)
X-AuditID: cbfec370-c37ff70000014b76-00-60cd181330cc
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 82.08.48268.2181DC06; Fri,
        18 Jun 2021 18:02:58 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Fri, 18 Jun 2021 15:02:58 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::255d:1bae:c3ae:e3c3]) by
        SSI-EX1.ssi.samsung.com ([fe80::255d:1bae:c3ae:e3c3%7]) with mapi id
        15.01.2242.008; Fri, 18 Jun 2021 15:02:58 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v3 04/16] block: Introduce the ioprio rq-qos policy
Thread-Topic: [PATCH v3 04/16] block: Introduce the ioprio rq-qos policy
Thread-Index: AQHXY9s0eiEL9yXCU0ay4HvtHUC3aasayQaA
Date:   Fri, 18 Jun 2021 22:02:57 +0000
Message-ID: <20210618220257.GA210778@bgt-140510-bm01>
In-Reply-To: <20210618004456.7280-5-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <030F86B0B744554BBC3CEB7028A646D0@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djX87rCEmcTDD5M5bZYfbefzWLah5/M
        Fq3t35gs9iyaxGSxcvVRJosbC94wWjxZP4vZ4m/XPSaLvbe0LQ5NbmZy4PK4fMXb4/LZUo9N
        qzrZPHbfbGDz+Pj0FovH+31X2Tw2n672+LxJzqP9QDdTAGcUl01Kak5mWWqRvl0CV0bf5SmM
        BZuqK94vsG1gvJ7YxcjJISFgIrHk0z7GLkYuDiGBlYwS7z7MYIVwWpkkXh+ZwgZXdXESVGIt
        o0Tz19lMEM5HRonuH/vYIZwDjBLP735kBmlhEzCQ+H18I5gtIqAh8e3BchaQImaBD0wSh+f9
        ZgVJCAu4S7zZuhCqyEPi3Yb/TBC2kcT0c48ZQWwWAVWJQ733WUBsXgFTiQ1fL4PdxClgLjH3
        1FuwOKOAmMT3U2vAepkFxCVuPZnPBHG3oMSi2XuYIWwxiX+7HkL9oyhx//tLdoh6HYkFuz+x
        Qdh2Egd6z0HZ2hLLFr5mhtgrKHFy5hMWiF5JiYMrboA9IyHQzCmxu6GTFSLhInFn5mSoZdIS
        V69PZYYo2sUoMWf2R1YI5zCjxKYLyxkhqqwlbrzsYpzAqDILyeWzkFw1C8lVs5BcNQvJVQsY
        WVcxipcWF+empxYb56WW6xUn5haX5qXrJefnbmIEJrnT/w4X7GC8deuj3iFGJg7GQ4wSHMxK
        IrycmWcShHhTEiurUovy44tKc1KLDzFKc7AoifPOjZwYLySQnliSmp2aWpBaBJNl4uCUamA6
        tNwwwfL1TeXWycLPLpyTl7qx1Irn4LT6Xy8+/JWV2dymuPxvc8dr7teuN2bsX2Kt8YGX88zc
        /MBs9gTz7Dudz0Q1uHu9ljgdjiv98S97/pNv9wLFrC+k/zTs+l3F7+er9rOs0i9iLrtRZmXI
        EXPfyXG7XjberxGUmKa1e/8V803d7xr3cZmdrawN0d+YvqHc7zRzjOqORdurS41ces59/8c1
        26wieI53s+ymzSlH1mxoPnOtveZq0FO+1VeXq5181rdV4Vy4rVzz55ie4OPZt5r3cusu3iJv
        +EN7GS/nlJP7ZGcFL5oTcfzHtlorHa6MtJszbuqYiE5g2LL70JcJmS5b2MsOPBHvZNecrMqj
        xFKckWioxVxUnAgABuPkpeEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsWS2cA0SVdI4myCwcwOHYvVd/vZLKZ9+Mls
        0dr+jcliz6JJTBYrVx9lsrix4A2jxZP1s5gt/nbdY7LYe0vb4tDkZiYHLo/LV7w9Lp8t9di0
        qpPNY/fNBjaPj09vsXi833eVzWPz6WqPz5vkPNoPdDMFcEZx2aSk5mSWpRbp2yVwZfRdnsJY
        sKm64v0C2wbG64ldjJwcEgImEksuTmLtYuTiEBJYzSjx6uB8dgjnI6PEt0W7mCGcA4wSL773
        sYC0sAkYSPw+vpEZxBYR0JD49mA5C0gRs8AHJokfOz+CFQkLuEu82boQqshD4t2G/0wQtpHE
        9HOPGUFsFgFViUO998HqeQVMJTZ8vcwGsW07o0Tvjz9gCU4Bc4m5p96C2YwCYhLfT60BG8Qs
        IC5x68l8JognBCSW7DnPDGGLSrx8/I8VwlaUuP/9JTtEvY7Egt2f2CBsO4kDveegbG2JZQtf
        M0McIShxcuYTFoheSYmDK26wTGCUmIVk3Swko2YhGTULyahZSEYtYGRdxSheWlycm15RbJiX
        Wq5XnJhbXJqXrpecn7uJEZgcTv87HLmD8eitj3qHGJk4GA8xSnAwK4nwcmaeSRDiTUmsrEot
        yo8vKs1JLT7EKM3BoiTOK+Q6MV5IID2xJDU7NbUgtQgmy8TBKdXA5MptEMT5Wzew0pCJ+ZZk
        8oszfmui2o/MDRT5rf/Aart35sJCPhXBUNu1B+f9rO4pczuub3X2RK+J+5u9Cr+uGyQWX1h/
        NGuDk57atdh/Rjkf5W/kVufeMHE31LAsE96tJzrPu2LC+78zGC4tuhUXUhK9Jsb6hEzgo9Id
        B1zyTGb/a6woeLPh2AzHWJuTxS5djrNPf9Xnd9V9rdSs8FxgodImuUflTd1b326JrLQ9rJ+u
        My9zyYzkXcJnU4TtIgrvlijs4X21c2lp9edjrQ3CR5On3mR93Sa10P1f2cGk5fueRCewvHab
        1PdDcU3M2cw9v2cvW/FAw1tILD7iom/3viC+rGVPyuu/HTzLmt+sxFKckWioxVxUnAgAOMTE
        o30DAAA=
X-CMS-MailID: 20210618220258uscas1p26dd26e2908d8466831cf8089a181ded7
CMS-TYPE: 301P
X-CMS-RootMailID: 20210618004513uscas1p22b7df0c0db59d5b8e2fd01c7cc475be4
References: <20210618004456.7280-1-bvanassche@acm.org>
        <CGME20210618004513uscas1p22b7df0c0db59d5b8e2fd01c7cc475be4@uscas1p2.samsung.com>
        <20210618004456.7280-5-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 17, 2021 at 05:44:44PM -0700, Bart Van Assche wrote:
> Introduce an rq-qos policy that assigns an I/O priority to requests based
> on blk-cgroup configuration settings. This policy has the following
> advantages over the ioprio_set() system call:
> - This policy is cgroup based so it has all the advantages of cgroups.
> - While ioprio_set() does not affect page cache writeback I/O, this rq-qo=
s
>   controller affects page cache writeback I/O for filesystems that suppor=
t
>   assiociating a cgroup with writeback I/O. See also
>   Documentation/admin-guide/cgroup-v2.rst.
>=20
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  55 +++++
>  block/Kconfig                           |   9 +
>  block/Makefile                          |   1 +
>  block/blk-cgroup.c                      |   5 +
>  block/blk-ioprio.c                      | 262 ++++++++++++++++++++++++
>  block/blk-ioprio.h                      |  19 ++
>  block/blk-mq-debugfs.c                  |   2 +
>  block/blk-rq-qos.h                      |   1 +
>  8 files changed, 354 insertions(+)
>  create mode 100644 block/blk-ioprio.c
>  create mode 100644 block/blk-ioprio.h
>=20
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index b1e81aa8598a..4e59925e6583 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -56,6 +56,7 @@ v1 is available under :ref:`Documentation/admin-guide/c=
group-v1/index.rst <cgrou
>         5-3-3. IO Latency
>           5-3-3-1. How IO Latency Throttling Works
>           5-3-3-2. IO Latency Interface Files
> +       5-3-4. IO Priority
>       5-4. PID
>         5-4-1. PID Interface Files
>       5-5. Cpuset
> @@ -1866,6 +1867,60 @@ IO Latency Interface Files
>  		duration of time between evaluation events.  Windows only elapse
>  		with IO activity.  Idle periods extend the most recent window.
> =20
> +IO Priority
> +~~~~~~~~~~~
> +
> +A single attribute controls the behavior of the I/O priority cgroup poli=
cy,
> +namely the blkio.prio.class attribute. The following values are accepted=
 for
> +that attribute:
> +
> +  no-change
> +	Do not modify the I/O priority class.
> +
> +  none-to-rt
> +	For requests that do not have an I/O priority class (NONE),
> +	change the I/O priority class into RT. Do not modify
> +	the I/O priority class of other requests.
> +
> +  restrict-to-be
> +	For requests that do not have an I/O priority class or that have I/O
> +	priority class RT, change it into BE. Do not modify the I/O priority
> +	class of requests that have priority class IDLE.
> +
> +  idle
> +	Change the I/O priority class of all requests into IDLE, the lowest
> +	I/O priority class.
> +
> +The following numerical values are associated with the I/O priority poli=
cies:
> +
> ++-------------+---+
> +| no-change   | 0 |
> ++-------------+---+
> +| none-to-rt  | 1 |
> ++-------------+---+
> +| rt-to-be    | 2 |
> ++-------------+---+
> +| all-to-idle | 3 |
> ++-------------+---+
> +
> +The numerical value that corresponds to each I/O priority class is as fo=
llows:
> +
> ++-------------------------------+---+
> +| IOPRIO_CLASS_NONE             | 0 |
> ++-------------------------------+---+
> +| IOPRIO_CLASS_RT (real-time)   | 1 |
> ++-------------------------------+---+
> +| IOPRIO_CLASS_BE (best effort) | 2 |
> ++-------------------------------+---+
> +| IOPRIO_CLASS_IDLE             | 3 |
> ++-------------------------------+---+
> +
> +The algorithm to set the I/O priority class for a request is as follows:
> +
> +- Translate the I/O priority class policy into a number.
> +- Change the request I/O priority class into the maximum of the I/O prio=
rity
> +  class policy number and the numerical I/O priority class.
> +
>  PID
>  ---
> =20
> diff --git a/block/Kconfig b/block/Kconfig
> index 6685578b2a20..e71c63eaaf52 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -162,6 +162,15 @@ config BLK_CGROUP_IOCOST
>  	distributes IO capacity between different groups based on
>  	their share of the overall weight distribution.
> =20
> +config BLK_CGROUP_IOPRIO
> +	bool "Cgroup I/O controller for assigning an I/O priority class"
> +	depends on BLK_CGROUP
> +	help
> +	Enable the .prio interface for assigning an I/O priority class to
> +	requests. The I/O priority class affects the order in which an I/O
> +	scheduler and block devices process requests. Only some I/O schedulers
> +	and some block devices support I/O priorities.
> +
>  config BLK_DEBUG_FS
>  	bool "Block layer debugging information in debugfs"
>  	default y
> diff --git a/block/Makefile b/block/Makefile
> index 8d841f5f986f..af3d044abaf1 100644
> --- a/block/Makefile
> +++ b/block/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_BLK_DEV_BSGLIB)	+=3D bsg-lib.o
>  obj-$(CONFIG_BLK_CGROUP)	+=3D blk-cgroup.o
>  obj-$(CONFIG_BLK_CGROUP_RWSTAT)	+=3D blk-cgroup-rwstat.o
>  obj-$(CONFIG_BLK_DEV_THROTTLING)	+=3D blk-throttle.o
> +obj-$(CONFIG_BLK_CGROUP_IOPRIO)	+=3D blk-ioprio.o
>  obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+=3D blk-iolatency.o
>  obj-$(CONFIG_BLK_CGROUP_IOCOST)	+=3D blk-iocost.o
>  obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+=3D mq-deadline.o
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 3b0f6efaa2b6..7b06a5fa3cac 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -31,6 +31,7 @@
>  #include <linux/tracehook.h>
>  #include <linux/psi.h>
>  #include "blk.h"
> +#include "blk-ioprio.h"
> =20
>  /*
>   * blkcg_pol_mutex protects blkcg_policy[] and policy [de]activation.
> @@ -1187,6 +1188,10 @@ int blkcg_init_queue(struct request_queue *q)
>  	if (ret)
>  		goto err_destroy_all;
> =20
> +	ret =3D blk_ioprio_init(q);
> +	if (ret)
> +		goto err_destroy_all;
> +
>  	ret =3D blk_throtl_init(q);
>  	if (ret)
>  		goto err_destroy_all;
> diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
> new file mode 100644
> index 000000000000..332a07761bf8
> --- /dev/null
> +++ b/block/blk-ioprio.c
> @@ -0,0 +1,262 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Block rq-qos policy for assigning an I/O priority class to requests.
> + *
> + * Using an rq-qos policy for assigning I/O priority class has two advan=
tages
> + * over using the ioprio_set() system call:
> + *
> + * - This policy is cgroup based so it has all the advantages of cgroups=
.
> + * - While ioprio_set() does not affect page cache writeback I/O, this r=
q-qos
> + *   controller affects page cache writeback I/O for filesystems that su=
pport
> + *   assiociating a cgroup with writeback I/O. See also
> + *   Documentation/admin-guide/cgroup-v2.rst.
> + */
> +
> +#include <linux/blk-cgroup.h>
> +#include <linux/blk-mq.h>
> +#include <linux/blk_types.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include "blk-ioprio.h"
> +#include "blk-rq-qos.h"
> +
> +/**
> + * enum prio_policy - I/O priority class policy.
> + * @POLICY_NO_CHANGE: (default) do not modify the I/O priority class.
> + * @POLICY_NONE_TO_RT: modify IOPRIO_CLASS_NONE into IOPRIO_CLASS_RT.
> + * @POLICY_RESTRICT_TO_BE: modify IOPRIO_CLASS_NONE and IOPRIO_CLASS_RT =
into
> + *		IOPRIO_CLASS_BE.
> + * @POLICY_ALL_TO_IDLE: change the I/O priority class into IOPRIO_CLASS_=
IDLE.
> + *
> + * See also <linux/ioprio.h>.
> + */
> +enum prio_policy {
> +	POLICY_NO_CHANGE	=3D 0,
> +	POLICY_NONE_TO_RT	=3D 1,
> +	POLICY_RESTRICT_TO_BE	=3D 2,
> +	POLICY_ALL_TO_IDLE	=3D 3,
> +};
> +
> +static const char *policy_name[] =3D {
> +	[POLICY_NO_CHANGE]	=3D "no-change",
> +	[POLICY_NONE_TO_RT]	=3D "none-to-rt",
> +	[POLICY_RESTRICT_TO_BE]	=3D "restrict-to-be",
> +	[POLICY_ALL_TO_IDLE]	=3D "idle",
> +};
> +
> +static struct blkcg_policy ioprio_policy;
> +
> +/**
> + * struct ioprio_blkg - Per (cgroup, request queue) data.
> + * @pd: blkg_policy_data structure.
> + */
> +struct ioprio_blkg {
> +	struct blkg_policy_data pd;
> +};
> +
> +/**
> + * struct ioprio_blkcg - Per cgroup data.
> + * @cpd: blkcg_policy_data structure.
> + * @prio_policy: One of the IOPRIO_CLASS_* values. See also <linux/iopri=
o.h>.
> + */
> +struct ioprio_blkcg {
> +	struct blkcg_policy_data cpd;
> +	enum prio_policy	 prio_policy;
> +};
> +
> +static inline struct ioprio_blkg *pd_to_ioprio(struct blkg_policy_data *=
pd)
> +{
> +	return pd ? container_of(pd, struct ioprio_blkg, pd) : NULL;
> +}
> +
> +static struct ioprio_blkcg *blkcg_to_ioprio_blkcg(struct blkcg *blkcg)
> +{
> +	return container_of(blkcg_to_cpd(blkcg, &ioprio_policy),
> +			    struct ioprio_blkcg, cpd);
> +}
> +
> +static struct ioprio_blkcg *
> +ioprio_blkcg_from_css(struct cgroup_subsys_state *css)
> +{
> +	return blkcg_to_ioprio_blkcg(css_to_blkcg(css));
> +}
> +
> +static struct ioprio_blkcg *ioprio_blkcg_from_bio(struct bio *bio)
> +{
> +	struct blkg_policy_data *pd =3D blkg_to_pd(bio->bi_blkg, &ioprio_policy=
);
> +
> +	if (!pd)
> +		return NULL;
> +
> +	return blkcg_to_ioprio_blkcg(pd->blkg->blkcg);
> +}
> +
> +static int ioprio_show_prio_policy(struct seq_file *sf, void *v)
> +{
> +	struct ioprio_blkcg *blkcg =3D ioprio_blkcg_from_css(seq_css(sf));
> +
> +	seq_printf(sf, "%s\n", policy_name[blkcg->prio_policy]);
> +	return 0;
> +}
> +
> +static ssize_t ioprio_set_prio_policy(struct kernfs_open_file *of, char =
*buf,
> +				      size_t nbytes, loff_t off)
> +{
> +	struct ioprio_blkcg *blkcg =3D ioprio_blkcg_from_css(of_css(of));
> +	int ret;
> +
> +	if (off !=3D 0)
> +		return -EIO;
> +	/* kernfs_fop_write_iter() terminates 'buf' with '\0'. */
> +	ret =3D sysfs_match_string(policy_name, buf);
> +	if (ret < 0)
> +		return ret;
> +	blkcg->prio_policy =3D ret;
> +
> +	return nbytes;
> +}
> +
> +static struct blkg_policy_data *
> +ioprio_alloc_pd(gfp_t gfp, struct request_queue *q, struct blkcg *blkcg)
> +{
> +	struct ioprio_blkg *ioprio_blkg;
> +
> +	ioprio_blkg =3D kzalloc(sizeof(*ioprio_blkg), gfp);
> +	if (!ioprio_blkg)
> +		return NULL;
> +
> +	return &ioprio_blkg->pd;
> +}
> +
> +static void ioprio_free_pd(struct blkg_policy_data *pd)
> +{
> +	struct ioprio_blkg *ioprio_blkg =3D pd_to_ioprio(pd);
> +
> +	kfree(ioprio_blkg);
> +}
> +
> +static struct blkcg_policy_data *ioprio_alloc_cpd(gfp_t gfp)
> +{
> +	struct ioprio_blkcg *blkcg;
> +
> +	blkcg =3D kzalloc(sizeof(*blkcg), gfp);
> +	if (!blkcg)
> +		return NULL;
> +	blkcg->prio_policy =3D POLICY_NO_CHANGE;
> +	return &blkcg->cpd;
> +}
> +
> +static void ioprio_free_cpd(struct blkcg_policy_data *cpd)
> +{
> +	struct ioprio_blkcg *blkcg =3D container_of(cpd, typeof(*blkcg), cpd);
> +
> +	kfree(blkcg);
> +}
> +
> +#define IOPRIO_ATTRS						\
> +	{							\
> +		.name		=3D "prio.class",			\
> +		.seq_show	=3D ioprio_show_prio_policy,	\
> +		.write		=3D ioprio_set_prio_policy,	\
> +	},							\
> +	{ } /* sentinel */
> +
> +/* cgroup v2 attributes */
> +static struct cftype ioprio_files[] =3D {
> +	IOPRIO_ATTRS
> +};
> +
> +/* cgroup v1 attributes */
> +static struct cftype ioprio_legacy_files[] =3D {
> +	IOPRIO_ATTRS
> +};
> +
> +static struct blkcg_policy ioprio_policy =3D {
> +	.dfl_cftypes	=3D ioprio_files,
> +	.legacy_cftypes =3D ioprio_legacy_files,
> +
> +	.cpd_alloc_fn	=3D ioprio_alloc_cpd,
> +	.cpd_free_fn	=3D ioprio_free_cpd,
> +
> +	.pd_alloc_fn	=3D ioprio_alloc_pd,
> +	.pd_free_fn	=3D ioprio_free_pd,
> +};
> +
> +struct blk_ioprio {
> +	struct rq_qos rqos;
> +};
> +
> +static void blkcg_ioprio_track(struct rq_qos *rqos, struct request *rq,
> +			       struct bio *bio)
> +{
> +	struct ioprio_blkcg *blkcg =3D ioprio_blkcg_from_bio(bio);
> +
> +	/*
> +	 * Except for IOPRIO_CLASS_NONE, higher I/O priority numbers
> +	 * correspond to a lower priority. Hence, the max_t() below selects
> +	 * the lower priority of bi_ioprio and the cgroup I/O priority class.
> +	 * If the cgroup policy has been set to POLICY_NO_CHANGE =3D=3D 0, the
> +	 * bio I/O priority is not modified. If the bio I/O priority equals
> +	 * IOPRIO_CLASS_NONE, the cgroup I/O priority is assigned to the bio.
> +	 */
> +	bio->bi_ioprio =3D max_t(u16, bio->bi_ioprio,
> +			       IOPRIO_PRIO_VALUE(blkcg->prio_policy, 0));
> +}
> +
> +static void blkcg_ioprio_exit(struct rq_qos *rqos)
> +{
> +	struct blk_ioprio *blkioprio_blkg =3D
> +		container_of(rqos, typeof(*blkioprio_blkg), rqos);
> +
> +	blkcg_deactivate_policy(rqos->q, &ioprio_policy);
> +	kfree(blkioprio_blkg);
> +}
> +
> +static struct rq_qos_ops blkcg_ioprio_ops =3D {
> +	.track	=3D blkcg_ioprio_track,
> +	.exit	=3D blkcg_ioprio_exit,
> +};
> +
> +int blk_ioprio_init(struct request_queue *q)
> +{
> +	struct blk_ioprio *blkioprio_blkg;
> +	struct rq_qos *rqos;
> +	int ret;
> +
> +	blkioprio_blkg =3D kzalloc(sizeof(*blkioprio_blkg), GFP_KERNEL);
> +	if (!blkioprio_blkg)
> +		return -ENOMEM;
> +
> +	ret =3D blkcg_activate_policy(q, &ioprio_policy);
> +	if (ret) {
> +		kfree(blkioprio_blkg);
> +		return ret;
> +	}
> +
> +	rqos =3D &blkioprio_blkg->rqos;
> +	rqos->id =3D RQ_QOS_IOPRIO;
> +	rqos->ops =3D &blkcg_ioprio_ops;
> +	rqos->q =3D q;
> +
> +	/*
> +	 * Registering the rq-qos policy after activating the blk-cgroup
> +	 * policy guarantees that ioprio_blkcg_from_bio(bio) !=3D NULL in the
> +	 * rq-qos callbacks.
> +	 */
> +	rq_qos_add(q, rqos);
> +
> +	return 0;
> +}
> +
> +static int __init ioprio_init(void)
> +{
> +	return blkcg_policy_register(&ioprio_policy);
> +}
> +
> +static void __exit ioprio_exit(void)
> +{
> +	blkcg_policy_unregister(&ioprio_policy);
> +}
> +
> +module_init(ioprio_init);
> +module_exit(ioprio_exit);
> diff --git a/block/blk-ioprio.h b/block/blk-ioprio.h
> new file mode 100644
> index 000000000000..a7785c2f1aea
> --- /dev/null
> +++ b/block/blk-ioprio.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _BLK_IOPRIO_H_
> +#define _BLK_IOPRIO_H_
> +
> +#include <linux/kconfig.h>
> +
> +struct request_queue;
> +
> +#ifdef CONFIG_BLK_CGROUP_IOPRIO
> +int blk_ioprio_init(struct request_queue *q);
> +#else
> +static inline int blk_ioprio_init(struct request_queue *q)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#endif /* _BLK_IOPRIO_H_ */
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 6ac1c86f62ef..4b66d2776eda 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -946,6 +946,8 @@ static const char *rq_qos_id_to_name(enum rq_qos_id i=
d)
>  		return "latency";
>  	case RQ_QOS_COST:
>  		return "cost";
> +	case RQ_QOS_IOPRIO:
> +		return "ioprio";
>  	}
>  	return "unknown";
>  }
> diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
> index a77afbdd472c..f000f83e0621 100644
> --- a/block/blk-rq-qos.h
> +++ b/block/blk-rq-qos.h
> @@ -17,6 +17,7 @@ enum rq_qos_id {
>  	RQ_QOS_WBT,
>  	RQ_QOS_LATENCY,
>  	RQ_QOS_COST,
> +	RQ_QOS_IOPRIO,
>  };
> =20
>  struct rq_wait {


Looks good and is working as expected, here are some IOPs from a local
loopback device using this feature and the BFQ scheduler

APP     CGRP_PRIO_ON    CGRP_PRIO_OFF

IDLE    51.2K           67.2K
RT      93.6K           67.4

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Tested by: Adam Manzanares <a.manzanares@samsung.com>=
