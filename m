Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34228 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751321AbcJJWdA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2016 18:33:00 -0400
Received: by mail-qk0-f196.google.com with SMTP id n189so215651qke.1
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2016 15:32:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87wphk3gpx.fsf@notabene.neil.brown.name>
References: <1473152338-30539-1-git-send-email-tomasz.majchrzak@intel.com> <87wphk3gpx.fsf@notabene.neil.brown.name>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 10 Oct 2016 15:32:58 -0700
Message-ID: <CAA9_cmcnQjKv=tdBF+Jkd6WoFh+aKCVzq7NPQBStwtcv_j0Qyg@mail.gmail.com>
Subject: Re: [PATCH] badblocks: fix overlapping check for clearing
To: NeilBrown <neilb@suse.com>
Cc: Tomasz Majchrzak <tomasz.majchrzak@intel.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Oct 6, 2016 at 9:50 PM, NeilBrown <neilb@suse.com> wrote:
> On Tue, Sep 06 2016, Tomasz Majchrzak wrote:
>
>> Current bad block clear implementation assumes the range to clear
>> overlaps with at least one bad block already stored. If given range to
>> clear precedes first bad block in a list, the first entry is incorrectly
>> updated.
>
> In the original md context, it would only ever be called on a block that
> was already in the list.
> But you are right that it is best not to assume this, and to code more
> safely.
>
>
>
>>
>> Check not only if stored block end is past clear block end but also if
>> stored block start is before clear block end.
>>
>> Signed-off-by: Tomasz Majchrzak <tomasz.majchrzak@intel.com>
>
> Dan Williams seems to have taken responsibility for this code through
> his nvdimm tree, so I've added him to 'cc' in the hope that he looks at
> this (I wonder if he is even on linux-block ....)

I am, but I missed this, thanks for the cc.

>
>
>> ---
>>  block/badblocks.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/badblocks.c b/block/badblocks.c
>> index 7be53cb..b2ffcc7 100644
>> --- a/block/badblocks.c
>> +++ b/block/badblocks.c
>> @@ -354,7 +354,8 @@ int badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
>>                * current range.  Earlier ranges could also overlap,
>>                * but only this one can overlap the end of the range.
>>                */
>> -             if (BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > target) {
>> +             if ((BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > target) &&
>> +                 (BB_OFFSET(p[lo]) <= target)) {
>
> hmmm..
> 'target' is the sector just beyond the set of sectors to remove from the
> list.
> BB_OFFSET(p[lo]) is the first sector in a range that was found in the
> list.
> If these are equal, then are aren't clearing anything in this range.
> So I would have '<', not '<='.
>
> I don't think this makes the code wrong as we end up assigning to p[lo]
> the value that is already there.  But it might be confusing.
>
>
>>                       /* Partial overlap, leave the tail of this range */
>>                       int ack = BB_ACK(p[lo]);
>>                       sector_t a = BB_OFFSET(p[lo]);
>> @@ -377,7 +378,8 @@ int badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
>>                       lo--;
>>               }
>>               while (lo >= 0 &&
>> -                    BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > s) {
>> +                    (BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > s) &&
>> +                    (BB_OFFSET(p[lo]) <= target)) {
>
> Ditto.
>
> But the code is, I think, correct. Just not how I would have written it.
> So
>
>  Acked-by: NeilBrown <neilb@suse.com>

I agree with the comments to change "<=" to "<".  Tomasz, care to
re-send with those changes?
