Return-Path: <joe@perches.com>
Message-ID: <87e66800d9e991499c43c2bcd5b0772f2dfa8ba8.camel@perches.com>
Subject: Re: [PATCH 4.17.0-rc3 1/1]partition: Remove trailing spaces and
 correct indenting
From: Joe Perches <joe@perches.com>
To: kidega <kidegamoses88@gmail.com>, axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Date: Wed, 20 Jun 2018 08:41:13 -0700
In-Reply-To: <20180620161434.GA3513@kidega-PC>
References: <20180620161434.GA3513@kidega-PC>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-06-20 at 19:14 +0300, kidega wrote:
> Reply-To:

It seems this is your first attempt to patch something
in the linux kernel.

You should read https://kernelnewbies.org/ and you
should start with files in drivers/staging.

The Reply-To: line should not exist here

> > remove trailing spaces
> > correct indenting 

The leading "> " uses should not exist here.

> Signed-off-by: kidega <kidegamoses88@gmail.com>

You need your full legal name here.

> diff --git a/block/partitions/mac.c b/block/partitions/mac.c

This file probably does not need style changes as
it's pretty old and unlikely to change.

But if it did:

> @@ -97,16 +97,14 @@ int mac_partition(struct parsed_partitions *state)
>  			int goodness = 0;
>  
>  			mac_fix_string(part->processor, 16);
> -			mac_fix_string(part->name, 32);
> -			mac_fix_string(part->type, 32);					
> -		    
> +			mac_fix_string(part->name, 32); mac_fix_string(part->type, 32);

This needs separate lines for each single statement.

>  			if ((be32_to_cpu(part->status) & MAC_STATUS_BOOTABLE)
>  			    && strcasecmp(part->processor, "powerpc") == 0)
>  				goodness++;
>  
>  			if (strcasecmp(part->type, "Apple_UNIX_SVR2") == 0
> -			    || (strncasecmp(part->type, "Linux", 5) == 0
> -			        && strcasecmp(part->type, "Linux_swap") != 0)) {
> +				|| (strncasecmp(part->type, "Linux", 5) == 0
> +				&& strcasecmp(part->type, "Linux_swap") != 0)) {

This is making the indentation worse as the parenthesized
sub-test block is now unaligned.

And some would prefer moving the && || to the end of the
previous line like:
---
 block/partitions/mac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/partitions/mac.c b/block/partitions/mac.c
index b6095335636c..897da77e5379 100644
--- a/block/partitions/mac.c
+++ b/block/partitions/mac.c
@@ -98,15 +98,15 @@ int mac_partition(struct parsed_partitions *state)
 
 			mac_fix_string(part->processor, 16);
 			mac_fix_string(part->name, 32);
-			mac_fix_string(part->type, 32);					
-		    
-			if ((be32_to_cpu(part->status) & MAC_STATUS_BOOTABLE)
-			    && strcasecmp(part->processor, "powerpc") == 0)
+			mac_fix_string(part->type, 32);
+
+			if ((be32_to_cpu(part->status) & MAC_STATUS_BOOTABLE) &&
+			    strcasecmp(part->processor, "powerpc") == 0)
 				goodness++;
 
-			if (strcasecmp(part->type, "Apple_UNIX_SVR2") == 0
-			    || (strncasecmp(part->type, "Linux", 5) == 0
-			        && strcasecmp(part->type, "Linux_swap") != 0)) {
+			if (strcasecmp(part->type, "Apple_UNIX_SVR2") == 0 ||
+			    (strncasecmp(part->type, "Linux", 5) == 0 &&
+			     strcasecmp(part->type, "Linux_swap") != 0)) {
 				int i, l;
 
 				goodness++;
