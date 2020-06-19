Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A7BC433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 16:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 123BD21707
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 16:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvGmgj5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390064AbgFSQ1O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:27:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34272 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390405AbgFSQ1I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 12:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592584028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mZFD93MLr2SHmpmqv6lmYfLnc6UHqO7AHltgO7VAs2g=;
        b=AvGmgj5r1l3lx4dyweXR8tLBMGrLg1qjfGeSwBY/GdbzSR/qkwkHhikWwPtWoa+MZ9M2F2
        IykTp0svogeSGDYThe+GhwGLM1Ad6hKZQrg1ajidS5ZpYKEwJWCAfFBXXnTUm9X3MTaw3c
        TdbTUd8eO4OHWc2xC/iMGdLruy3gEQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-ygk5jDPbMkywf-JpdVT3YA-1; Fri, 19 Jun 2020 12:27:04 -0400
X-MC-Unique: ygk5jDPbMkywf-JpdVT3YA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C7CA464;
        Fri, 19 Jun 2020 16:27:03 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2042D5D9EF;
        Fri, 19 Jun 2020 16:27:00 +0000 (UTC)
Date:   Fri, 19 Jun 2020 12:26:59 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [RFC PATCH 2/2] dm: don't try to split REQ_OP_ZONE_APPEND bios
Message-ID: <20200619162658.GB24642@redhat.com>
References: <20200619065905.22228-1-johannes.thumshirn@wdc.com>
 <20200619065905.22228-3-johannes.thumshirn@wdc.com>
 <CY4PR04MB37514CDC42E7F545244D66C6E7980@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR04MB37514CDC42E7F545244D66C6E7980@CY4PR04MB3751.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 19 2020 at  3:54am -0400,
Damien Le Moal <Damien.LeMoal@wdc.com> wrote:

> On 2020/06/19 15:59, Johannes Thumshirn wrote:
> > REQ_OP_ZONE_APPEND bios cannot be split so return EIO if we can't fit it
> > into one IO.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---
> >  drivers/md/dm.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > index 058c34abe9d1..c720a7e3269a 100644
> > --- a/drivers/md/dm.c
> > +++ b/drivers/md/dm.c
> > @@ -1609,6 +1609,9 @@ static int __split_and_process_non_flush(struct clone_info *ci)
> >  
> >  	len = min_t(sector_t, max_io_len(ci->sector, ti), ci->sector_count);
> >  
> > +	if (bio_op(ci->bio) == REQ_OP_ZONE_APPEND && len < ci->sector_count)
> > +		return -EIO;
> > +
> >  	r = __clone_and_map_data_bio(ci, ti, ci->sector, &len);
> >  	if (r < 0)
> >  		return r;
> > 
> 
> I think this is OK. The stacked max_zone_append_sectors limit should have
> prevented that to happen  in the first place I think, but better safe than sorry.
> 
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

If stacked max_zone_append_sectors limit should prevent it then I'd
rather not sprinkle more zoned specific checks in DM core.

Thanks,
Mike

