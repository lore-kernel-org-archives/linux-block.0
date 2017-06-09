Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHv8 2/2] loop: support 4k physical blocksize
To: Bart Van Assche <bart.vanassche@wdc.com>, Hannes Reinecke <hare@suse.de>
Cc: Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <1496922405-38302-1-git-send-email-hare@suse.de>
 <1496922405-38302-3-git-send-email-hare@suse.de>
 <b70e5a20-8dcf-677d-3574-051a5a6e22ad@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fd3d3cad-a08a-67b7-0c71-7b7e4212c518@kernel.dk>
Date: Fri, 9 Jun 2017 09:33:44 -0600
MIME-Version: 1.0
In-Reply-To: <b70e5a20-8dcf-677d-3574-051a5a6e22ad@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/09/2017 09:30 AM, Bart Van Assche wrote:
> On 06/08/17 04:46, Hannes Reinecke wrote:
>>  	if (lo->lo_offset != info->lo_offset ||
>> -	    lo->lo_sizelimit != info->lo_sizelimit)
>> -		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
>> +	    lo->lo_sizelimit != info->lo_sizelimit ||
>> +	    lo->lo_flags != lo_flags ||
>> +	    ((lo->lo_flags & LO_FLAGS_BLOCKSIZE) &&
>> +	     lo->lo_logical_blocksize != LO_INFO_BLOCKSIZE(info))) {
>> +		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit,
>> +				     LO_INFO_BLOCKSIZE(info)))
>>  			err = -EFBIG;
>>  			goto exit;
>>  		}
> 
> Hello Hannes and Jens,
> 
> gcc reports the following for the above code:
> 
> drivers/block/loop.c:1149:3: warning: this 'if' clause does not guard...
> [-Wmisleading-indentation]
> 
> Please review this code. Have the braces perhaps been misplaced?

It's clearly buggy, fix has gone in:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-4.13/block&id=b040ad9cf6a169cc000a5324fcada695dfa1f4b3

-- 
Jens Axboe
