Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33437 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933408AbdA0Rdt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 12:33:49 -0500
Subject: Re: split scsi passthrough fields out of struct request V2
To: Christoph Hellwig <hch@lst.de>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
 <20170127161114.GA501@kernel.dk> <20170127161718.GA16911@lst.de>
 <775aff8d-6bcc-9cc5-cfa3-dd1c157c95c5@fb.com> <20170127162316.GA17059@lst.de>
 <195e1638-7d85-0618-0101-5cfff34b91e9@fb.com> <20170127163450.GA17311@lst.de>
CC: Mike Snitzer <snitzer@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-raid@vger.kernel.org>, <dm-devel@redhat.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <f0305c67-4aca-e2cf-d729-3ceb93d2cc50@fb.com>
Date: Fri, 27 Jan 2017 09:38:40 -0700
MIME-Version: 1.0
In-Reply-To: <20170127163450.GA17311@lst.de>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/27/2017 09:34 AM, Christoph Hellwig wrote:
> On Fri, Jan 27, 2017 at 09:27:02AM -0700, Jens Axboe wrote:
>> Feel free to repost it, I have no problem rebasing that branch as it's
>> standalone for now.
> 
> Ok, I'll repost what I have right now, which is on top of a merge
> of your block/for-4.11/next and your for-next from this morning
> my time.

Perfect.

> Btw, I disagred with your patch to use op_is_flush in
> generic_make_request_checks - given that we clear these flags just
> below I think using the helper obsfucates what's really going on.

Why? It's the exact same check. The ugly part is the fact that
we strip the flags later on, imho.

-- 
Jens Axboe

