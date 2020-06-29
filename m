Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD1DC433DF
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 20:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 109512067D
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 20:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="kwAl2Udf";
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="kwAl2Udf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgF2UbR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:31:17 -0400
Received: from fallback9.mail.ru ([94.100.178.49]:52564 "EHLO
        fallback9.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387869AbgF2UbH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 16:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=XLFhjsVZkSmLniWsWHyqLabQ/LXs2iBnPp8E8C1b5n4=;
        b=kwAl2Udfkzfo1WdA6y8u2Qduv43ErHN1HqLQqid0Bhjj0nV6fUP3xjNbACQs4JG0x93lgySFbcXfd0Z8uYHT9StsM8E17nz3XC2USXRYLEwzPr2cWvq1oUf0BxFeb93QDE/D1T9WcyR7lakGPcOJGhVVnDqOae8tJ/hAnPAV7bk=;
Received: from [10.161.64.37] (port=57066 helo=smtp29.i.mail.ru)
        by fallback9.m.smailru.net with esmtp (envelope-from <alekseymmm@mail.ru>)
        id 1jq0Qh-0004Xd-Tb
        for linux-block@vger.kernel.org; Mon, 29 Jun 2020 23:31:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=XLFhjsVZkSmLniWsWHyqLabQ/LXs2iBnPp8E8C1b5n4=;
        b=kwAl2Udfkzfo1WdA6y8u2Qduv43ErHN1HqLQqid0Bhjj0nV6fUP3xjNbACQs4JG0x93lgySFbcXfd0Z8uYHT9StsM8E17nz3XC2USXRYLEwzPr2cWvq1oUf0BxFeb93QDE/D1T9WcyR7lakGPcOJGhVVnDqOae8tJ/hAnPAV7bk=;
Received: by smtp29.i.mail.ru with esmtpa (envelope-from <alekseymmm@mail.ru>)
        id 1jq0Qf-0004Bc-KX; Mon, 29 Jun 2020 23:31:02 +0300
Message-ID: <5d0e6d2dbe0754ea3909e1356d45649c86aa4c47.camel@mail.ru>
Subject: Re: [PATCH] block: Set req quiet flag if bio is quiet
From:   Aleksei Marov <alekseymmm@mail.ru>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Date:   Mon, 29 Jun 2020 23:31:00 +0300
In-Reply-To: <CACVXFVObNuK=Uii_Tm2pSEEm2RAeECeha97-q=+XkDsuD6Vmsg@mail.gmail.com>
References: <bdef634a3a41dbecfd3d74f6bd25332445772902.camel@mail.ru>
         <CACVXFVObNuK=Uii_Tm2pSEEm2RAeECeha97-q=+XkDsuD6Vmsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9AAC5A87EC32CE31EB6E01BDE3D7D768BA8AF3A12D18E8808182A05F538085040C3ED374BDF95FAFC33C15FBE7B6A060D9BCBF3C5A9230834A419E6AAC0FD7CAB
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE728F774C865CF4B07EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AAEFEF2B38A4D0058638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FCE7B7E25C7B2699E956DF8A5C64B117DB0F79B94EB1BFA845389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0D9442B0B5983000E8941B15DA834481FCF19DD082D7633A0E7DDDDC251EA7DABA471835C12D1D977725E5C173C3A84C317B107DEF921CE79117882F4460429728AD0CFFFB425014E40A5AABA2AD371193AA81AA40904B5D9A18204E546F3947CE3786DD2C77EBDAA6E0066C2D8992A164AD6D5ED66289B52F4A82D016A4342E36136E347CC761E07725E5C173C3A84C3A4C8B69FD63482ABBA3038C0950A5D36B5C8C57E37DE458B0B4866841D68ED3567F23339F89546C55F5C1EE8F4F765FC374CE26A9E38610E75ECD9A6C639B01BBD4B6F7A4D31EC0BC0CAF46E325F83A522CA9DD8327EE4930A3850AC1BE2E735B17145F0B7815491C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-C8649E89: 2523EEA3D8CA14D657F9682BC97966FBC73A3C8D8BD6F9E88F015620A5DFF824E8FD65A201054E84
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj9CrQpifGHskw+sMRDA+W3A==
X-Mailru-Internal-Actual: A:0.89651890133537
X-Mailru-Sender: 8261CADE3D3FA0B4BDFD1058942BD7EA885A991C30C598018D7351001B2B8E437F7019A35B9DBA63FEDCCAD94ABAB60078274A4A9E9E44FD4301F6103F424F867A458BE9B16E12C867EA787935ED9F1B
X-Mras: Ok
X-7564579A: EEAE043A70213CC8
X-77F55803: 6AF0DA0BABFA9FDB7F9F52485CB584D7271FD7DF62800FDCDCB70D7AF48B0E24A870C7F939FDA4DFC076B2D7564F02F5D3E5B1672D07EA7B
X-7FA49CB5: 0D63561A33F958A56DB79C3193ADEBF9BC791FF0A5F672ED213801E70CE5CC258941B15DA834481FA18204E546F3947C1D471462564A2E19F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BAA867293B0326636D2E47CDBA5A965834E70A05D1297E1BBBA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C0BF77E1FFDBD4BA897B076A6E789B0E97A8DF7F3B2552694ABCFECBEA56A8F1E193EC92FD9297F6718AA50765F7900637C3090DF2C0002BD1A7F4EDE966BC389F395957E7521B51C24C7702A67D5C33162DBA43225CD8A89FB26E97DCB74E6252A91E23F1B6B78B78B5C8C57E37DE458B4C7702A67D5C3316FA3894348FB808DB48C21F01D89DB561574AF45C6390F7469DAA53EE0834AAEE
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj9CrQpifGHskAWSvDDtwu9A==
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C9005DD084BBBA291661D5157D3A6DA29EFDCA870C7F939FDA4DFE23824BA0C9766A7BA06D6758C6957D0C77752E0C033A69EE9C7C6BE7440F28B4CF838113C6AC4B43453F38A29522196
X-Mras: Ok
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 2020-06-27 at 16:00 +0800, Ming Lei wrote:
> On Sat, Jun 27, 2020 at 2:12 AM Aleksei Marov <alekseymmm@mail.ru>
> wrote:
> > The current behavior is that if bio flagged as BIO_QUIETis
> > submitted to request based block device then the request
> > that wraps this bio in a queue is not quiet. RQF_FLAG is not
> > set anywhere. Hence, if errors happen we can see error
> > messages (e.g. in print_req_error) even though bio is quiet.
> > This patch fixes that by setting the flag in blk_rq_bio_prep.
> > 
> > Signed-off-by: Aleksei Marov <alekseymmm@mail.ru>
> > ---
> >  block/blk.h | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/block/blk.h b/block/blk.h
> > index b5d1f0f..04ca4e0 100644
> > --- a/block/blk.h
> > +++ b/block/blk.h
> > @@ -108,6 +108,9 @@ static inline void blk_rq_bio_prep(struct
> > request
> > *rq, struct bio *bio,
> > 
> >         if (bio->bi_disk)
> >                 rq->rq_disk = bio->bi_disk;
> > +
> > +       if (bio_flagged(bio, BIO_QUIET))
> > +               rq->rq_flags |= RQF_QUIET;
> >  }
> 
> BIO_QUIET consumer is fs code, and RQF_QUIET consumer is block layer,
> so you think
> the two consumers' expectation is same?
> 
Hi Ming Lei, thanks for your comment, I appreciate it since it is the
first time I send a patch to the kernel. Regarding your point, it makes
sense to me that the two consumers' expectations are the same. Correct
me if I am wrong. I never found a good explanation of this relationship
between bio and req of lower devices.  Maybe this "quiet" behavior is
not important or very rare.
Besides, I think that not only fs works with bio, but some bio could be
allocated and handled entirely within the block layer, e.g. in stacked
block devices like mdraid, may be lvm.

