Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCHv8 2/2] loop: support 4k physical blocksize
To: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
CC: Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
	<linux-block@vger.kernel.org>, Hannes Reinecke <hare@suse.com>
References: <1496922405-38302-1-git-send-email-hare@suse.de>
 <1496922405-38302-3-git-send-email-hare@suse.de>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <b70e5a20-8dcf-677d-3574-051a5a6e22ad@wdc.com>
Date: Fri, 9 Jun 2017 08:30:43 -0700
MIME-Version: 1.0
In-Reply-To: <1496922405-38302-3-git-send-email-hare@suse.de>
Content-Type: text/plain; charset="utf-8"
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 06/08/17 04:46, Hannes Reinecke wrote:
>  	if (lo->lo_offset != info->lo_offset ||
> -	    lo->lo_sizelimit != info->lo_sizelimit)
> -		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
> +	    lo->lo_sizelimit != info->lo_sizelimit ||
> +	    lo->lo_flags != lo_flags ||
> +	    ((lo->lo_flags & LO_FLAGS_BLOCKSIZE) &&
> +	     lo->lo_logical_blocksize != LO_INFO_BLOCKSIZE(info))) {
> +		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit,
> +				     LO_INFO_BLOCKSIZE(info)))
>  			err = -EFBIG;
>  			goto exit;
>  		}

Hello Hannes and Jens,

gcc reports the following for the above code:

drivers/block/loop.c:1149:3: warning: this 'if' clause does not guard...
[-Wmisleading-indentation]

Please review this code. Have the braces perhaps been misplaced?

Thanks,

Bart.
