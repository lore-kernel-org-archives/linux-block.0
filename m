Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC59C35E04
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 19:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627FD21744
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 19:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgBYTyJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:54:09 -0500
Received: from mx1.emlix.com ([188.40.240.192]:54560 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgBYTyJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 14:54:09 -0500
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id E3F1D5F9B0;
        Tue, 25 Feb 2020 20:54:07 +0100 (CET)
Subject: Re: [dm-devel] [PATCH] dm integrity: reinitialize __bi_remaining when
 reusing bio
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
References: <20200225170744.10485-1-dg@emlix.com>
 <20200225191222.GA3908@infradead.org>
From:   =?UTF-8?Q?Daniel_Gl=c3=b6ckner?= <dg@emlix.com>
Openpgp: preference=signencrypt
Organization: emlix GmbH
Message-ID: <a932a297-266e-4dee-f030-40ecbc9899ca@emlix.com>
Date:   Tue, 25 Feb 2020 20:54:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20200225191222.GA3908@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Christoph,

Am 02/25/20 um 20:12 schrieb Christoph Hellwig:
> On Tue, Feb 25, 2020 at 06:07:44PM +0100, Daniel Glöckner wrote:
>> In cases where dec_in_flight has to requeue the integrity_bio_wait work
>> to transfer the rest of the data, the __bi_remaining field of the bio
>> might already have been decremented to zero. Reusing the bio without
>> reinitializing that counter to 1 can then result in integrity_end_io
>> being called too early when the BIO_CHAIN flag is set, f.ex. due to
>> blk_queue_split. In our case this triggered the BUG() in
>> blk_mq_end_request when the hardware signalled completion of the bio
>> after integrity_end_io had modified it.
>>
>> Signed-off-by: Daniel Glöckner <dg@emlix.com>
> 
> Drivers have no business poking into these internals.  If a bio is
> reused the caller needs to use bio_reset instead.

bio_reset will reset too many fields. As you can see in the context of
the diff, dm-integrity expects f.ex. the values modified by bio_advance
to stay intact and the transfer should of course use the same disk and
operation.

How about doing the atomic_set in bio_remaining_done (in block/bio.c)
where the BIO_CHAIN flag is cleared once __bi_remaining hits zero?
Or is requeuing a bio without bio_reset really a no-go? In that case a
one-liner won't do...

Best regards,

  Daniel

-- 
Besuchen Sie uns auf der Embedded World 2020 in Nürnberg!
-> Halle 4, Stand 368

Dipl.-Math. Daniel Glöckner, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11,
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke
Ust-IdNr.: DE 205 198 055

emlix - your embedded linux partner
