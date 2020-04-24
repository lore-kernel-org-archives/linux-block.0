Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DA8C55186
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 16:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A2382075A
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 16:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gvrKnrWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgDXQMF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:12:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53496 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgDXQMF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 12:12:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03OG9EOi055412;
        Fri, 24 Apr 2020 16:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=iWJG6Ue7eDyGNHLhQ4Nc0jptIYtXauZMl/Jbdz8bR3I=;
 b=gvrKnrWeQDxrobuStPCpex/fnpXGHRQe8+VXO+R5Qmw4qhM8ksmVFiRl/e8EaP/SMG0h
 GKpESFFFGe/dOjd5kc4u5uJLCt7OSFIrlxxatkX4ELjnVL5EUxCBLZcUHSG/RUp19pQR
 elC7nTQQYnmTfPusvxDduV6rAApXv0XYfctrwX3AuYjF3XYyytak53H3sxffyxSPzy1B
 UTmrL/R9tp/UAa0/uxx8cChTDm6hGoH+T0jB8oq0d9+hnxcg019Z5ftVdImdtRxZBFJ2
 76AZd7hltH8QGxN4scTgcyUS8HwbhFb8U8yXxtUpY4z6yv5Mz4dEaAZt6sE2zksSGi9p qQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30k7qe7rjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 16:11:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03OG80bq097859;
        Fri, 24 Apr 2020 16:11:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30k7qxea9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 16:11:37 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03OGBYM9031155;
        Fri, 24 Apr 2020 16:11:34 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Apr 2020 09:11:34 -0700
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Subject: Re: [PATCH V8 01/11] block: clone nr_integrity_segments and write_hint in blk_rq_prep_clone
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200424102351.475641-1-ming.lei@redhat.com>
        <20200424102351.475641-2-ming.lei@redhat.com>
Date:   Fri, 24 Apr 2020 12:11:31 -0400
In-Reply-To: <20200424102351.475641-2-ming.lei@redhat.com> (Ming Lei's message
        of "Fri, 24 Apr 2020 18:23:41 +0800")
Message-ID: <yq1zhb0eudo.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9601 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004240125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9601 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240125
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Ming,

> So far blk_rq_prep_clone() is only used for setup one underlying
> cloned request from dm-rq request. block intetrity can be enabled for
> both dm-rq and the underlying queues, so it is reasonable to clone
> rq's nr_integrity_segments. Also write_hint is from bio, it should
> have been cloned too.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
