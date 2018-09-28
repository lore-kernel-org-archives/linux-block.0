Return-Path: <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH] xen/blkfront: correct purging of persistent grants
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org
Cc: roger.pau@citrix.com, konrad.wilk@oracle.com, axboe@kernel.dk
References: <20180928072827.14229-1-jgross@suse.com>
 <95e32835-426f-36c9-a86a-09563f090f22@oracle.com>
 <772c3886-d4fe-b912-b125-a648b31a3074@suse.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <b454645f-de15-2912-864e-18f00736013d@oracle.com>
Date: Fri, 28 Sep 2018 09:33:13 -0400
MIME-Version: 1.0
In-Reply-To: <772c3886-d4fe-b912-b125-a648b31a3074@suse.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/28/18 9:13 AM, Juergen Gross wrote:
> On 28/09/2018 14:45, Boris Ostrovsky wrote:
>> On 9/28/18 3:28 AM, Juergen Gross wrote:
>>> Commit a46b53672b2c2e3770b38a4abf90d16364d2584b ("xen/blkfront: cleanup
>>> stale persistent grants") introduced a regression as purged persistent
>>> grants were not pu into the list of free grants again. Correct that.
>>>
>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>> ---
>>>  drivers/block/xen-blkfront.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
>>> index a71d817e900d..429d20131c7e 100644
>>> --- a/drivers/block/xen-blkfront.c
>>> +++ b/drivers/block/xen-blkfront.c
>>> @@ -2670,8 +2670,8 @@ static void purge_persistent_grants(struct blkfront_info *info)
>>>  			list_del(&gnt_list_entry->node);
>>>  			gnttab_end_foreign_access(gnt_list_entry->gref, 0, 0UL);
>>>  			rinfo->persistent_gnts_c--;
>>> -			__free_page(gnt_list_entry->page);
>>> -			kfree(gnt_list_entry);
>>> +			gnt_list_entry->gref = GRANT_INVALID_REF;
>>> +			list_add_tail(&gnt_list_entry->node, &rinfo->grants);
>> Sorry, I don't follow this. What is the purpose of removing the grant
>> from rinfo->grants list with list_del() and then adding it back with
>> list_add_tail()?
> The persistent grants are at the list head and the non-persistent ones
> at the tail.

Oh, I didn't realize that. But isn't that an optimization (and so not
following this rule should not cause errors)?

-boris
