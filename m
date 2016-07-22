Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:42029 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbcGVTeR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 22 Jul 2016 15:34:17 -0400
To: Florian-Ewald =?utf-8?Q?M=C3=BCller?=
	<florian-ewald.mueller@profitbricks.com>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH linux-4.7-rc7] blk_stack_limits() setting discard_granularity
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CAHJVUehBe1zKvp==CUs0YkmRt5sT8qOES6bPnaeNKKsfuZ3Zrw@mail.gmail.com>
Date: Fri, 22 Jul 2016 15:34:06 -0400
In-Reply-To: <CAHJVUehBe1zKvp==CUs0YkmRt5sT8qOES6bPnaeNKKsfuZ3Zrw@mail.gmail.com>
	("Florian-Ewald =?utf-8?Q?M=C3=BCller=22's?= message of "Fri, 22 Jul 2016
 16:49:37
	+0200")
Message-ID: <yq1shv1bh75.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Florian-Ewald" == Florian-Ewald Müller <florian-ewald.mueller@profitbricks.com> writes:

Florian-Ewald,

Florian-Ewald> blk_stack_limits() can set discard_granularity bigger
Florian-Ewald> than max_discard_sectors (in bytes).

discard_granularity must be smaller than max_discard_sectors. The
question is which storage device reported these values?

-- 
Martin K. Petersen	Oracle Linux Engineering
