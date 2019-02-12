Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F7BC282CA
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 16:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E7D2184E
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 16:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oX/Xn2Su"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbfBLQra (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:47:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60242 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730844AbfBLQr3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 11:47:29 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1CGhp0r145776;
        Tue, 12 Feb 2019 16:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=1wofqb9/fkyDx2OI0+iElXtq3/BKWApe3iz2P9LvOto=;
 b=oX/Xn2SujmbaBFCFopVkLzxf4T2bkzNf9az/PFOymLxj4y4DED+DYzovbnTlGXDdW+Fj
 zGh1+O1RETQTKVA18gbGWoUqAUWwPnZ1PDy0NbHFChQYcsVMCm3JshGMu2t5BgZZkC05
 5/rmXEl+iZDSR4eUb+ImWYr4Sp/VSkLW31VvKnO301SvJolxd3F5/AxjFiMLrytVCPze
 q3AIj9IbGvVFj0vp2NGJeN/D08dV3O8bDyCdA8orq787Cj8fYt52XpgiguNjw+fNq9Tk
 q8S9/Iw6GO92Yr0UKCdwidNNzLeCeif9iM9CANqnacAsefSzNZNOHlioYscr+Oj+YJ0a NA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qhrekd4ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 16:47:16 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1CGlFbd009621
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 16:47:16 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1CGlFM7020783;
        Tue, 12 Feb 2019 16:47:15 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Feb 2019 08:47:15 -0800
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Jeremy Cline <jeremy@jcline.org>,
        Oleksii Kurochko <olkuroch@cisco.com>, stable@vger.kernel.org
Subject: Re: [PATCH] scsi: sd: block: Handle cases where devices come online read-only
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190208233831.31377-1-martin.petersen@oracle.com>
        <20190212080319.GA10547@infradead.org>
Date:   Tue, 12 Feb 2019 11:47:12 -0500
In-Reply-To: <20190212080319.GA10547@infradead.org> (Christoph Hellwig's
        message of "Tue, 12 Feb 2019 00:03:19 -0800")
Message-ID: <yq1d0nxuf73.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902120119
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Christoph,

>> Some devices come online in write protected state and switch to
>> read-write once they are ready to process I/O requests.
>
> That is really weird.  What kind of devices are these?

There are several. I have many bug reports, ranging from USB sticks to
arrays.

>> Note that per-partition ro settings are lost on revalidate. This has
>> been broken for at least a decade and it will require major surgery to
>> fix. To my knowledge nobody has complained about being unable to make
>> partition read-only settings stick through a revalidate. So hopefully
>> this patch will suffice as a simple fix for stable.
>
> Should we warn when we lost these settings on a revalidate?

Would be nice. But as I wrote, it's going to require major surgery to
the gendisk code to handle this particular scenario correctly since we
currently do not keep any partition state between revalidate calls.

> I have to say I don't like the tristate too much - it seems to allow
> setting a hardware write protected device writable again by user
> interfaction, right?

The original policy was that the user policy was ineffective since the
device setting always won.

Jeremy's patch allowed the user setting to override the device setting
but broke the case where devices subsequently change state at runtime.

My workaround is that the user ioctl ro state, if set, overrides
whatever the device reports. And once the user clears the flag, the
current device setting will take effect on revalidate.

> Should we just have a hardware and a user policy field that are
> separate instead?

All this needs to be completely rewritten. However, my attempt at fixing
it up properly got pretty convoluted and thus unsuitable for stable.

The intent with this patch was merely as a workaround for people stuck
with write-protected drives after boot. The tristate wasn't my first
choice, but it turned out to be the path of least resistance for a
stable fix.

-- 
Martin K. Petersen	Oracle Linux Engineering
