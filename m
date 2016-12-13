Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:54785 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934564AbcLMU1z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2016 15:27:55 -0500
Subject: Re: [LSF/MM TOPIC] Un-addressable device memory and block/fs
 implications
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jerome Glisse <jglisse@redhat.com>
References: <20161213181511.GB2305@redhat.com>
 <1481653252.2473.51.camel@HansenPartnership.com>
 <20161213185545.GC2305@redhat.com>
 <1481659264.2473.59.camel@HansenPartnership.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <4878d525-70cd-fa0e-b17f-4222c3166e74@intel.com>
Date: Tue, 13 Dec 2016 12:27:53 -0800
MIME-Version: 1.0
In-Reply-To: <1481659264.2473.59.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/13/2016 12:01 PM, James Bottomley wrote:
>> > Second aspect is that even if memory i am dealing with is un
>> > -addressable i still have struct page for it and i want to be able to 
>> > use regular page migration.
> Tmem keeps a struct page ... what's the problem with page migration?
> the fact that tmem locks the page when it's not addressable and you
> want to be able to migrate the page even when it's not addressable?

Hi James,

Why do you say that tmem keeps a 'struct page'?  For instance, its
->put_page operation _takes_ a 'struct page', but that's in the
delete_from_page_cache() path where the page's last reference has been
dropped and it is about to go away.  The role of 'struct page' here is
just to help create a key so that tmem can find the contents later
*without* the original 'struct page'.

Jerome's pages here are a new class of half-crippled 'struct page' which
support more VM features than ZONE_DEVICE pages, but not quite a full
feature set.  It supports (and needs to support) a heck of a lot more VM
features than memory in tmem would, though.


