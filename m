Return-Path: <SRS0=Jk+C=3L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEA8C33CB6
	for <linux-block@archiver.kernel.org>; Wed, 22 Jan 2020 05:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F262465A
	for <linux-block@archiver.kernel.org>; Wed, 22 Jan 2020 05:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E59LJAWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgAVFY3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jan 2020 00:24:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27823 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725730AbgAVFY3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jan 2020 00:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579670667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lqD6NkPb0a0cRYm99h6Qp0ka2aQ8TvFNBsgz8XqdNWo=;
        b=E59LJAWhCOHonapSdmndG+WBLOtN9QSiS6M9eA9rsthh9ddTR8TUItN8f3sk/NVpvkPTld
        YmvU9ieSZ8FKmtjcVPwAzO2kD/14t7CkvA90t/GrVb7d4FIlmmH3EXe9B5XruoWUyDuoZL
        9HoubIZZGxjnJvDZ9hSIUSjVf/o1kjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-6M1irsAyOiKcV_gd7QM_3g-1; Wed, 22 Jan 2020 00:24:23 -0500
X-MC-Unique: 6M1irsAyOiKcV_gd7QM_3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F3AD1005502;
        Wed, 22 Jan 2020 05:24:22 +0000 (UTC)
Received: from redhat.com (ovpn-112-7.rdu2.redhat.com [10.10.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 80EAF60C81;
        Wed, 22 Jan 2020 05:24:20 +0000 (UTC)
Date:   Tue, 21 Jan 2020 21:21:18 -0800
From:   Jerome Glisse <jglisse@redhat.com>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Generic page write protection
Message-ID: <20200122052118.GE76712@redhat.com>
References: <20200122023222.75347-1-jglisse@redhat.com>
 <20200122042832.GA6542@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200122042832.GA6542@hsiangkao-HP-ZHAN-66-Pro-G1>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 22, 2020 at 12:28:39PM +0800, Gao Xiang wrote:
> Hi J=EF=BF=BDr=EF=BF=BDme,
>=20
> On Tue, Jan 21, 2020 at 06:32:22PM -0800, jglisse@redhat.com wrote:
> > From: J=EF=BF=BDr=EF=BF=BDme Glisse <jglisse@redhat.com>
> >=20
> >=20
>=20
> <snip>
>=20
> >=20
> > To avoid any regression risks the page->mapping field is left intact =
as
> > today for non write protect pages. This means that if you do not use =
the
> > page write protection mechanism then it can not regress. This is achi=
eve
> > by using an helper function that take the mapping from the context
> > (current function parameter, see above on how function are updated) a=
nd
> > the struct page. If the page is not write protected then it uses the
> > mapping from the struct page (just like today). The only difference
> > between before and after the patchset is that all fs functions that d=
o
> > need the mapping for a page now also do get it as a parameter but onl=
y
> > use the parameter mapping pointer if the page is write protected.
> >=20
> > Note also that i do not believe that once confidence is high that we
> > always passdown the correct mapping down each callstack, it does not
> > mean we will be able to get rid of the struct page mapping field.
>=20
> This feature is awesome and I might have some premature words here...
>=20
> In short, are you suggesting completely getting rid of all way to acces=
s
> mapping directly from struct page (other than by page->private or somet=
hing
> else like calling trace)?

No, all access to page->mapping are replace by:
    struct address_space *fs_page_mapping(struct page *page,
                                          struct address_space *mapping)
    {
        if (unlikely(!PageIsWriteProtected(page)))
            return page->mapping;
        return mapping;
    }

All function that where doing direct dereference are updated to use this
helper. If the function already has mapping in its context then it is
easy (there is a lot of place like that because you have file or inode or
mapping available from the function context).

If function does not have file, inode or mapping in its context then a
new mapping parameter is added to that function and all call site are
updated (and this does recurse ie if call site do not have file,inode or
mapping then a mapping parameter is added to them too ...).

This takes care of all fs code. The mm code is split between code that
deal with vma where we can get the mapping from the vma and mm code that
just want to walk all the CPU pte pointing to the page. In this latter
case we just need to provide CPU pte walkers for write protected pages
(like KSM does today).

The block device code only need the mapping on io error and they are
different strategy depending on individual fs. fs using buffer_head
can easily be updated. For other they are different solution and they
can be updated one at a time with tailor solution.


> I'm not sure if all cases can be handled without page->mapping easily (=
or
> handled effectively) since mapping field could also be used to indicate=
/judge
> truncated pages or some other filesystem specific states (okay, I think=
 there
> could be some replacement, but it seems a huge project...)

I forgot to talk about truncate, all place that test for truncate are
updated to:
    bool fs_page_is_truncated(struct page *page,
                              struct address_space *mapping)
    {
        if (unlikely(!PageIsWriteProtected(page)))
            return !page->mapping || mapping !=3D page->mapping;
        return wp_page_is_protected(page, mapping);
    }

Where wp_page_is_protected() will use common write protect mm code
(look at mm/ksm.c as it will be mostly that) to determine if the page
have been truncated. Also code doing truncation will have to special
case write protected page but that's easy enough.


> Currently, page->private is a per-page user-defined field, yet I don't =
think
> it could always be used as a pointer pointing to some structure. It can=
 be
> simply used to store some unsigned long values for some kinds of filesy=
stem
> pages as well...

For fs that use buffer_head i change buffer_head struct to store mapping
and not block_device. For other fs it will depend on the individual fs
but i am not changing page->private, i might only change the struct that
page->private points to for that specific fs.

>=20
> It might some ineffective to convert such above usage to individual per=
-page
> structure pointers --- from cacheline or extra memory overhead view...
>=20
> So I think at least there could be some another way to get its content
> source (inode or sub-inode granularity, a reverse way) effectively...
> by some field in struct page directly or indirectly...
>=20
> I agree that the usage of page->mapping field is complicated for now.
> I'm looking forward some unique way to mark the page type for a filesys=
tem
> to use (inode or fs internal special pages) or even extend to analymous
> pages [1]. However, it seems a huge project to keep from some regressio=
n...

Note that page->mapping stays _untouch_ if page is not write protected
so there is no memory lookup overhead, the only overhead is the extra
branch to test if the page is write protected or not.

So if you do not use the write protection feature then you can not
regress ie page->mapping is untouch and that's what get use like it is
today. So it can not regress unless i do stupid mistake, but that's
what review is for ;)).

>=20
> I'm interested in related stuffs, some conclusion and I saw the article=
 of
> LSF/MM 2018 although my English isn't good...
>=20
> If something wrong, please kindly point out...
>=20
> [1] https://lore.kernel.org/r/20191030172234.GA7018@hsiangkao-HP-ZHAN-6=
6-Pro-G1

Missed that thread thank you for the pointer, i have some reading to do :=
)

Cheers,
J=E9r=F4me Glisse

