Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710B8C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 01:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2FE20872
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 01:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xJJ0zNmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfCSBWZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 21:22:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38030 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfCSBWZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 21:22:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2J1J4Ea192372;
        Tue, 19 Mar 2019 01:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=vu5KNKQNVWCeTbLREMTDuW5pfSLe3uuLgNbKbCc9gBs=;
 b=xJJ0zNmQ0y1KUGxtwRVPHxth6g4ldJsXP/F+gq9fJV4PeGrQfXyAAwBEV4XZ5WJCY/m/
 3wN28ZKpH07ao6bdywBeEwHGiFE+gc3EhBiXy0J5bwATK/p1cc6WNRj9J0/+aJSVuGhv
 i0ZcWP6N5gcXf91PlHhQiND7611mjhOUljhHb+De8t5AZjs1qQBbMx9rIUnE+vkG+9lt
 /SO9bzaSqmkX5li0P/J/uFFSx+ShkXsc/qKVGqQggxJKZ26KHAYYkySfvcAomL/eVhp5
 Z/j8SltVEFViOPi6Ey7+wR5SWlAp+pMbbvnnXviTDXtsmmv8iyn3Vun8DYPOSf44Uldy XA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2r8ssr9nj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 01:21:59 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2J1LwjL017977
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 01:21:58 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2J1Lu8s022738;
        Tue, 19 Mar 2019 01:21:56 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Mar 2019 18:21:56 -0700
Subject: Re: [PATCH 0/8]: blk-mq: use static_rqs to iterate busy tags
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, jsmart2021@gmail.com,
        sagi@grimberg.me, josef@toxicpanda.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, hare@suse.de, jthumshirn@suse.de, hch@lst.de
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552930085.152266.36.camel@acm.org>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <3cd58454-eda3-de9a-0eed-b6a7edbce28f@oracle.com>
Date:   Tue, 19 Mar 2019 09:25:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552930085.152266.36.camel@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9199 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190008
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart

Thanks for your kindly and detailed comment on this.

On 3/19/19 1:28 AM, Bart Van Assche wrote:
> On Fri, 2019-03-15 at 16:57 +0800, Jianchao Wang wrote:
>> [2] https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dblock-26m-3D154526189023236-26w-3D2&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=_8Zz6iRpso8g7WlZ-WB50qqNkI2X2GRfySSBWyFKuI4&s=ZVNqSClQ_47hVGJpSrF5rbTh3X32cAlY-GFF2BPkGx0&e=
> 
> Hi Jianchao,
> 
> That is a reference to the "BUG: KASAN: use-after-free in bt_iter" issue.
> I think that issue can be fixed in another way than modifying all code that
> iterates over tags, namely by adding an rcu_read_lock() / rcu_read_unlock()
> pair in bt_for_each() and bt_tags_for_each() and by changing the calls in
> blk_mq_free_rqs() and blk_free_flush_queue() that free the data structures
> used by the tag iteration functions into kfree_rcu() or call_rcu() calls.

Do you mean this patch from Jens ?
https://marc.info/?l=linux-block&m=154534605914798&w=2

+	rcu_read_lock();
 	sbitmap_for_each_set(&bt->sb, bt_iter, &iter_data);
+	rcu_read_unlock();

The busy_iter_fn could sleep for nvme
blk_mq_check_expired
  -> blk_mq_rq_timed_out
    -> q->mq_ops->timeout
       nvme_timeout
         -> nvme_dev_disable
            -> mutex_lock dev->shutdown_lock

Thanks
Jianchao
