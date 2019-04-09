Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5300C10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 09:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7085E20830
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 09:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W0yADN1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfDIJsj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:48:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39152 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfDIJsj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 05:48:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x399Y63A060772;
        Tue, 9 Apr 2019 09:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=oq4eb7x7a96j787xemjpLUe8MnNPEZED6xbWGfWFay4=;
 b=W0yADN1CQ75xHyT2M86RC1NJza7Xa1lOSayPbhd5mGJDafnrgxPAvT7dfsJ9uTPXUa5U
 CO7FbbROGLmDMUkCHn0VUL6PEtwxEb+Zk0wR8fh4zlhtv5sHqfqU+5TPqU7VeOX6FYrx
 v5xPuzewlAFZxH3WlXXwNJhM53DFOjOL6SwDM+i50RGVKFvDuvIR1UV2adl8Xu/V5RYF
 rn9C7t9HH1as96osEmTEegqFr5OO8BI+0Zr5bGhMbsiU+zI1kVktY5Iewvji4R0kGqz9
 HqCPMlhkOLW7scnv5LjK2q2eg47r6R3yq7Se2R9UMgDJ9SZ+/iA60hfiWjoTo3TV+DN0 Ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2rpmrq3ssm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 09:48:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x399kRGd148533;
        Tue, 9 Apr 2019 09:46:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2rph7sfx3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 09:46:27 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x399kPmr009270;
        Tue, 9 Apr 2019 09:46:25 GMT
Received: from [10.182.71.93] (/10.182.71.93)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Apr 2019 02:46:25 -0700
Subject: Re: [PATCH V2] io_uring: introduce inline reqs for
 IORING_SETUP_IOPOLL
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1554787314-27179-1-git-send-email-jianchao.w.wang@oracle.com>
 <20190409093717.GA15391@infradead.org>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <c76b558c-bc12-3247-2bb5-986e5ffcba1f@oracle.com>
Date:   Tue, 9 Apr 2019 17:46:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409093717.GA15391@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=812
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904090063
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=832 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904090063
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph

On 4/9/19 5:37 PM, Christoph Hellwig wrote:
> On Tue, Apr 09, 2019 at 01:21:54PM +0800, Jianchao Wang wrote:
>> For the IORING_SETUP_IOPOLL case, all of the submission and
>> completion are handled under ctx->uring_lock or in SQ poll thread
>> context, so io_get_req and io_put_req has been serialized well.
>> The only exception is the asynchronous workqueue context where could
>> free the io_kiocb for error. To overcome this, we allocate a new
>> io_kiocb and free the previous inlined one.
>>
>> Based on this, we introduce the preallocated reqs list per ctx and
>> needn't to provide any lock to serialize the updating of list. The
>> performacne benefits from this. The test result of following fio
>> command
> 
> I really don't like the idea of exposing this to userspace.  Is
> there any good reason to not simply always allocate inline request
> up to a certain ring size?
> 
Sorry, I cannot get your point.
There is nothing exposed to userspace. We will try to allocated fixed 128
per-ctx preallocated reqs if IORING_SETUP_IOPOLL. When this inlined reqs
are used up, it will allocated reqs in old fashion.

Thanks
Jianchao
