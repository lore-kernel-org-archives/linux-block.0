Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510F7C43219
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 21:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647A3216C4
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 21:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfDYVTO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:19:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57521 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728469AbfDYVTN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 17:19:13 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x3PLJ6g3014498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Apr 2019 17:19:07 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 442D7420EEC; Thu, 25 Apr 2019 17:19:06 -0400 (EDT)
Date:   Thu, 25 Apr 2019 17:19:06 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [LSF/MM TOPIC] Lightning round?
Message-ID: <20190425211906.GH4739@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Jens Axboe <axboe@kernel.dk>, lsf-pc@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190425200012.GA6391@redhat.com>
 <83fda245-849a-70cc-dde0-5c451938ee97@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83fda245-849a-70cc-dde0-5c451938ee97@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 25, 2019 at 02:03:34PM -0600, Jens Axboe wrote:
> 
> which also includes a link to the schedule. Here it is:
> 
> https://docs.google.com/spreadsheets/d/1Z1pDL-XeUT1ZwMWrBL8T8q3vtSqZpLPgF3Bzu_jejfk

It looks like there are still quite a few open slots on Thursday?
Could we perhaps schedule a session for lightning talks?

I've got at least one thing that I'm hoping to be able to plug as a
lightning round topic.  Folks may remember that a year or two ago I
had given an LSF/MM talk about changes to the block layer to support
inline encryption engines[1] (where the data gets encrypted/decrypted
between the DMA engine and the storage device, typically EMCC/UFS
flash).

[1]  https://marc.info/?l=linux-fsdevel&m=148190956210784&w=2

Between the Android team really trying to get aligned with upstream,
and multiple SOC vendors interested in providing inline encryption
support in hardware, we (finally) have a few engineers who have been
on implementing this design for the past few months.  If all goes
well, hopefully RFC patches will be published on linux-block,
linux-fsdevel, and linux-fscrypto by early next week.  Assuming this
happens on schedule, it would be perfect for a lightning talk, with
the goal of commending this patch series for feedback.

						- Ted
