Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C97C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 02:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F76721904
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 02:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A5N9JxXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbfBNCcM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:32:12 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34138 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfBNCcM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 21:32:12 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1E2NtBo195745;
        Thu, 14 Feb 2019 02:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=c5taJN954cutuswTWfG5U+CDpxpAV+VcPXKP5vYMc6U=;
 b=A5N9JxXi6NQbXGVEDCLradKDIStkSxEnjXQmQczdWtpy48Us8UHDgqGnJ5904zJPOfRl
 s/1vocU5HexSPfKkEgEwCVqshQ4aPW1kyOOXJI7LlLks3aZEhXaFxrQhxrEdU8oppkpH
 7zqy3GH1Q/ECI77u9aXRuqgDFCtSDvnz2qCnSy9pO0qAqarSxkrhf25c2Gt6N75Cl80I
 7l7K8MjfFPigqLTGVARasD4R97FvxlvMeeZGD4n0ukAhECMN3SLHD2Phwg86JlLaUmZJ
 M6/GhJoAPfeaBdyzvIYwrVWbJpYPC+Orl61E13kYn7HWceGiv/+DeR+uPN6Yn+lHDz/+ kw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qhree5g6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 02:32:05 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1E2VxQZ024714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 02:31:59 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1E2Vx2Y026853;
        Thu, 14 Feb 2019 02:31:59 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 18:31:58 -0800
To:     Evan Green <evgreen@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] loop: Report EOPNOTSUPP properly
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190207205730.199332-1-evgreen@chromium.org>
        <20190207205730.199332-2-evgreen@chromium.org>
Date:   Wed, 13 Feb 2019 21:31:54 -0500
In-Reply-To: <20190207205730.199332-2-evgreen@chromium.org> (Evan Green's
        message of "Thu, 7 Feb 2019 12:57:28 -0800")
Message-ID: <yq1h8d7qew5.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=683 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140017
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Evan,

> Properly plumb out EOPNOTSUPP from loop driver operations, which may
> get returned when for instance a discard operation is attempted but
> not supported by the underlying block device. Before this change,
> everything was reported in the log as an I/O error, which is scary and
> not helpful in debugging.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
