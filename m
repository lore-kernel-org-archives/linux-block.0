Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47565 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932469AbcI2RAM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2016 13:00:12 -0400
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
To: Wouter Verhelst <w@uter.be>
References: <1475092892-8230-1-git-send-email-jbacik@fb.com>
 <20160929095204.mexr6wpypo3bl6mx@grep.be>
 <87908d95-0b7c-bc3f-f69d-94d006829daf@fb.com>
 <20160929164100.akytbkbtvziwaqqj@grep.be>
CC: <axboe@fb.com>, <linux-block@vger.kernel.org>,
        <kernel-team@fb.com>, <nbd-general@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
From: Josef Bacik <jbacik@fb.com>
Message-ID: <a2d8d560-41d0-e17d-90df-b1953ce00a51@fb.com>
Date: Thu, 29 Sep 2016 12:59:18 -0400
MIME-Version: 1.0
In-Reply-To: <20160929164100.akytbkbtvziwaqqj@grep.be>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/29/2016 12:41 PM, Wouter Verhelst wrote:
> On Thu, Sep 29, 2016 at 10:03:50AM -0400, Josef Bacik wrote:
>> So think of it like normal disks with multiple channels.  We don't send flushes
>> down all the hwq's to make sure they are clear, we leave that decision up to the
>> application (usually a FS of course).
>
> Well, when I asked earlier, Christoph said[1] that blk-mq assumes that
> when a FLUSH is sent over one channel, and the reply comes in, that all
> commands which have been received, regardless of which channel they were
> received over, have reched disk.
>
> [1] Message-ID: <20160915122304.GA15501@infradead.org>
>
> It is impossible for nbd to make such a guarantee, due to head-of-line
> blocking on TCP.
>

Huh I missed that.  Yeah that's not possible for us for sure, I think my option 
idea is the less awful way forward if we want to address that limitation.  Thanks,

Josef
